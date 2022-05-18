//
//  reviewViewModel.swift
//  Flying For Food
//
//  Created by Rice on 10/18/21.
//

import Foundation
import FirebaseFirestore

class reviewViewModel: ObservableObject{
    
    @Published var reviews: [review] = []
    static var textCorrespondingReview: review?
    
    init() {
        fetchData()
    }
    
    private var db = Firestore.firestore()
    
    func fetchData(){
        db.collection("review").addSnapshotListener{ (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self.reviews = documents.map { (queryDocumentSnapshot) -> review in
                let data = queryDocumentSnapshot.data()
                let IDENT = data["IDENT"] as? String ?? ""
                let restaurant = data["restaurant"] as? String ?? ""
                let thumbsUpCount = data["thumbsUpCount"] as? Int ?? 0
                let thumbsDownCount = data["thumbsDownCount"] as? Int ?? 0
                let review = review(restaurant: restaurant, IDENT: IDENT, thumbsUpCount: thumbsUpCount, thumbsDownCount: thumbsDownCount)
                return review
            }
        }
    }
    
    func isExisting(Ident: String, restaurant: String) -> Bool{
        for review in self.reviews {
            if (review.IDENT == Ident)
            {
                if (review.restaurant == restaurant)
                {
                    reviewViewModel.textCorrespondingReview = review
                    return true
                }
            }
        }
        return false
    }
    
    func getReview(Ident: String, restaurant: String) -> review {
        var result = review(restaurant: restaurant, IDENT: Ident, thumbsUpCount: 0, thumbsDownCount: 0)
        for review in self.reviews {
            if (review.IDENT == Ident)
            {
                if (review.restaurant == restaurant)
                {
                    result = review
                }
            }
        }
        return result
    }
    
    func deleteReview(name: String, identifer: String) {
        db.collection("review").document(name + " + " + identifer).delete()
    }
    
    func thumbsEdit(newUpValue: Int, newDownValue: Int, name: String, identifer: String){
        let db = Firestore.firestore()
        if isExisting(Ident: identifer, restaurant: name) {
            db.collection("review").document(name + " + " + identifer).updateData(["thumbsUpCount": newUpValue])
            db.collection("review").document(name + " + " + identifer).updateData(["thumbsDownCount": newDownValue])
        } else {
            db.collection("review").document(name + " + " + identifer).setData(["restaurant": name, "IDENT": identifer, "thumbsUpCount": newUpValue, "thumbsDownCount": newDownValue])
        }
    }
    
    func thumbsDownEdit(newValue: Int, name: String, identifer: String){
        let db = Firestore.firestore()
        if isExisting(Ident: identifer, restaurant: name) {
            db.collection("review").document(name + " + " + identifer).updateData(["thumbsDownCount": newValue])
        }
    }
    
    func addRevFromSuggs(name: String, identifier: String, suggCount: Int) {
        if !isExisting(Ident: identifier, restaurant: name) {
            db.collection("review").document(name + " + " + identifier).setData(["restaurant": name, "IDENT": identifier, "thumbsUpCount": suggCount, "thumbsDownCount": 0])
        }
    }
    
    func thumbsUpAdd(Ident: String, restaurant: String){
        let db = Firestore.firestore()
        let title = restaurant + " + " + Ident
        if (isExisting(Ident: Ident, restaurant: restaurant))
        {
            reviewViewModel.textCorrespondingReview?.thumbsUpCount += 1
            db.collection("review").document(title).setData(["restaurant": restaurant, "IDENT": Ident, "thumbsUpCount": reviewViewModel.textCorrespondingReview?.thumbsUpCount ?? 0, "thumbsDownCount": reviewViewModel.textCorrespondingReview?.thumbsDownCount ?? 0])
        }
        else{
            db.collection("review").document(title).setData(["restaurant": restaurant, "IDENT": Ident, "thumbsUpCount": 1, "thumbsDownCount": 0])
        }
    }
    
    func thumbsDownAdd(Ident: String, restaurant: String){
        let db = Firestore.firestore()
        let title = restaurant + " + " + Ident
        if (isExisting(Ident: Ident, restaurant: restaurant))
        {
            reviewViewModel.textCorrespondingReview?.thumbsDownCount += 1
            db.collection("review").document(title).setData(["restaurant": restaurant, "IDENT": Ident, "thumbsUpCount": reviewViewModel.textCorrespondingReview?.thumbsUpCount ?? 0, "thumbsDownCount": reviewViewModel.textCorrespondingReview?.thumbsDownCount ?? 0])
        }
        else{
            db.collection("review").document(title).setData(["restaurant": restaurant, "IDENT": Ident, "thumbsUpCount": 0, "thumbsDownCount": 1])
        }
    }
}
