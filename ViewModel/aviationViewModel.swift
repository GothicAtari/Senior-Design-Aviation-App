//
//  aviationViewModel.swift
//  Flying For Food
//
//  Created by Rice on 8/26/21.
//

import Foundation
import FirebaseFirestore

class aviationViewModel: ObservableObject{
    
    @Published var aviations: [aviation] = []
//    @Published var textCorrespondingAvia: aviation?
    static var textCorrespondingAvia: aviation?
    
    init() {
        fetchData()
    }
    
    private var db = Firestore.firestore()
    
    func fetchData(){
        db.collection("aviation").addSnapshotListener{ (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self.aviations = documents.map { (queryDocumentSnapshot) -> aviation in
                let data = queryDocumentSnapshot.data()
                let Breakfast = data["Breakfast"] as? String ?? ""
                let CityState = data["City/State"] as? String ?? ""
                let CoffeeShop = data["Coffee Shop"] as? String ?? ""
                let Dessert = data["Dessert"] as? String ?? ""
                let Dinner = data["Dinner"] as? String ?? ""
                let FBO = data["FBO"] as? String ?? ""
                let IDENT = data["IDENT"] as? String ?? ""
                let Lunch = data["Lunch"] as? String ?? ""
                let OtherOptionsNotes = data["Other Options & Notes"] as? String ?? ""
                let aviation = aviation(IDENT: IDENT , CityState: CityState, FBO: FBO, Breakfast: Breakfast, Lunch: Lunch, Dinner: Dinner, CoffeeShop: CoffeeShop, Dessert: Dessert, OtherOptionsNotes: OtherOptionsNotes)
                return aviation
            }
        }
    }
    
    func isSpecificData(ident: String) -> Bool{
        for avia in self.aviations {
            if (avia.IDENT.lowercased() == ident.lowercased())
            {
                aviationViewModel.textCorrespondingAvia = avia
                return true
            }
        }
        return false
    }
    
    func getAirportIdents() -> [String] {
        var airportIdents: [String] = []
        for avia in self.aviations {
            airportIdents.append(avia.IDENT)
        }
        return airportIdents
    }
    
    func airportCount() -> Int {
        return self.aviations.count
    }
    
    func addRestFromSuggs(breakfastSelected: Bool, lunchSelected: Bool, dinnerSelected: Bool, name: String, identifier: String) {
        if isSpecificData(ident: identifier) {
            addRestaurant(restaurantName: name, airportIdent: identifier, isBreakfast: breakfastSelected, isLunch: lunchSelected, isDinner: dinnerSelected)
        }
    }
    
    func isInMultipleMealTypes(name: String, identifier: String) -> Bool {
        var result = false
        var count = 0
        if isSpecificData(ident: identifier) {
            let breakfastArray = aviationViewModel.textCorrespondingAvia?.Breakfast.components(separatedBy: "; ") ?? []
            let lunchArray = aviationViewModel.textCorrespondingAvia?.Lunch.components(separatedBy: "; ") ?? []
            let dinnerArray = aviationViewModel.textCorrespondingAvia?.Dinner.components(separatedBy: "; ") ?? []
            
            if breakfastArray.contains(name) {
                count = count + 1
            }
            if lunchArray.contains(name) {
                count = count + 1
            }
            if dinnerArray.contains(name) {
                count = count + 1
            }
        }
        if count > 1 {
            result = true
        }
        return result
    }
    
    func deleteRestaurant(name: String, identifier: String, mealType: String) -> Void {
        //aviation
        var stringRests = ""
        if isSpecificData(ident: identifier) {
            if mealType == "Breakfast" {
                stringRests = aviationViewModel.textCorrespondingAvia?.Breakfast ?? ""
            }
            else if mealType == "Lunch" {
                stringRests = aviationViewModel.textCorrespondingAvia?.Lunch ?? ""
            }
            else {
                stringRests = aviationViewModel.textCorrespondingAvia?.Dinner ?? ""
            }
        }
        var restArray = stringRests.components(separatedBy: "; ")
        if restArray.contains(name) {
            restArray.remove(at: restArray.firstIndex(of: name) ?? 0)
            var newString = ""
            for i in restArray {
                if newString == "" {
                    newString = i
                }
                else {
                    newString.append("; " + i)
                }
            }
            db.collection("aviation").document(identifier).updateData([mealType: newString])
        }
        
    }
    
    func addRestaurant(restaurantName:String, airportIdent:String, isBreakfast:Bool, isLunch:Bool, isDinner:Bool) -> Bool {
        if isBreakfast == false && isLunch == false && isDinner == false {
            return false
        }
        for avia in self.aviations {
            if (avia.IDENT.lowercased() == airportIdent.lowercased())
            {
                if isBreakfast {
                    if avia.Breakfast == "" {
                        db.collection("aviation").document(airportIdent).updateData(["Breakfast": restaurantName])
                    }
                    else {
                        let restArray = avia.Breakfast.components(separatedBy: "; ")
                        if !restArray.contains(restaurantName) {
                            var newString = avia.Breakfast
                            newString.append("; \(restaurantName)")
                            db.collection("aviation").document(airportIdent).updateData(["Breakfast": newString])
                        }
                    }
                }
                if isLunch {
                    if avia.Lunch == "" {
                        db.collection("aviation").document(airportIdent).updateData(["Lunch": restaurantName])
                    }
                    else {
                        let restArray = avia.Lunch.components(separatedBy: "; ")
                        if !restArray.contains(restaurantName) {
                            var newString = avia.Lunch
                            newString.append("; \(restaurantName)")
                            db.collection("aviation").document(airportIdent).updateData(["Lunch": newString])
                        }
                    }
                }
                if isDinner {
                    if avia.Dinner == "" {
                        db.collection("aviation").document(airportIdent).updateData(["Dinner": restaurantName])
                    }
                    else {
                        let restArray = avia.Dinner.components(separatedBy: "; ")
                        if !restArray.contains(restaurantName) {
                            var newString = avia.Dinner
                            newString.append("; \(restaurantName)")
                            db.collection("aviation").document(airportIdent).updateData(["Dinner": newString])
                        }
                    }
                }
                return true
            }
        }
        return false
    }
}
