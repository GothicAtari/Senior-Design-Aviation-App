//
//  accountViewModel.swift
//  Flying For Food
//
//  Created by Rice on 9/25/21.
//

import Foundation
import FirebaseFirestore

class accountViewModel: ObservableObject{
    
    @Published var accounts: [account] = []
    static var textCorrespondingAccount: account?
    
    init() {
        fetchData()
    }
    
    private var db = Firestore.firestore()
    
    func fetchData(){
        db.collection("account").addSnapshotListener{ (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self.accounts = documents.map { (queryDocumentSnapshot) -> account in
                let data = queryDocumentSnapshot.data()
                let firstAndLastName = data["firstAndLastName"] as? String ?? ""
                let emailAddress = data["emailAddress"] as? String ?? ""
                let homeAirport = data["homeAirport"] as? String ?? ""
                let aircraftType = data["aircraftType"] as? String ?? ""
                let password = data["password"] as? String ?? ""
                let role = data["role"] as? String ?? ""
                let account = account(firstAndLastName: firstAndLastName, emailAddress: emailAddress, password: password, homeAirport: homeAirport, aircraftType: aircraftType, role: role)
                return account
            }
        }
    }
    
    func isCorrectAccount(email: String, password: String) -> Bool{
        for account in self.accounts {
            if (account.emailAddress.lowercased() == email.lowercased())
            {
                if (account.password == password)
                {
                    accountViewModel.textCorrespondingAccount = account
                    return true
                }
            }
        }
        return false
    }
    
//    func accountExists(email:String) -> Bool {
//        return true
//    }
    
//    func findAccount(email:String) -> account {
//        return
//    }
    
    func acccountCount() -> Int {
        return self.accounts.count
    }
    
    func upgradeAccount(email:String) -> Bool {
        for account in self.accounts {
            if (account.emailAddress.lowercased() == email.lowercased())
            {
                let db = Firestore.firestore()
                db.collection("account").document(account.firstAndLastName).updateData(["role": "admin"])
                return true
            }
        }
        return false
    }

    func isNotNull(email: String, password: String) -> Bool{
        if (!email.isEmpty) {
            return true
        }
        if (!password.isEmpty) {
            return true
        }
        return false
    }
}
