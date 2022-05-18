//
//  reviewViewModel.swift
//  Flying For Food
//
//  Created by Rice on 9/9/21.
//

import Foundation
import FirebaseFirestore

class suggestionViewModel: ObservableObject{
    
    @Published var suggestions: [suggestion] = []
    
    init() {
        fetchData()
    }
    
    private var db = Firestore.firestore()
    
    func fetchData(){
        db.collection("suggestion").addSnapshotListener{ (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self.suggestions = documents.map { (queryDocumentSnapshot) -> suggestion in
                let data = queryDocumentSnapshot.data()
                let IDENT = data["IDENT"] as? String ?? "No airport"
                let restaurantName = data["restaurantName"] as? String ?? "No restaurant"
                let typeOfMeal = data["typeOfMeal"] as? String ?? "No type"
                let comment = data["comment"] as? String ?? "No comment"
                let firstLastName = data["Name"] as? String ?? "No name"
                let suggestion = suggestion(IDENT: IDENT, restaurantName: restaurantName, typeOfMeal: typeOfMeal, comment: comment, firstLastName: firstLastName)
                return suggestion
            }
        }
    }
    
    func getSuggestions(airportIdent: String) -> [SuggestionCollection] {
        var suggCollections: [SuggestionCollection] = []
        //var suggestionsArray: [[suggestion]] = []
        for sugg in self.suggestions {
            let suggTest = SuggestionCollection(IDENT: sugg.IDENT, restaurantName: sugg.restaurantName, suggestions: [])
            if !suggCollections.contains(where: { suggCompare in
                if suggTest.IDENT == suggCompare.IDENT && suggTest.restaurantName == suggCompare.restaurantName {
                    return true
                } else {
                    return false
                }
            }) {
                suggCollections.append(suggTest)
            } 
        }
        for suggest in self.suggestions {
            for i in 0...(suggCollections.count - 1) {
                if suggest.IDENT == suggCollections[i].IDENT && suggest.restaurantName == suggCollections[i].restaurantName {
                    suggCollections[i].suggestions.append(suggest)
                }
            }
        }
        
        var resultSuggs: [SuggestionCollection] = []
        if airportIdent == "All" {
            resultSuggs = suggCollections
        } else {
            for sugCol in suggCollections {
                if sugCol.IDENT == airportIdent {
                    resultSuggs.append(sugCol)
                }
            }
        }
        
        resultSuggs = resultSuggs.sorted(by: {sugg1, sugg2 in
            sugg1.suggestions.count > sugg2.suggestions.count
        })
       
        
        return resultSuggs
    }
}
