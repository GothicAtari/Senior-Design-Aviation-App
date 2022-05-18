//
//  CreateAccount.swift
//  Flying For Food
//
//  Created by Rice on 10/7/21.
//

import SwiftUI
import FirebaseFirestore

struct CreateAccount: View {
    @State var name: String = ""
    @State var email: String = ""
    @State var homeAirport: String = ""
    @State var aircraftType: String = ""
    @State var password: String = ""
    @State var role: String = "user"
    @Environment(\.presentationMode) var presentationMode
    let filterTypeOfPerson: [String] = [
        "Pilot", "Aircrew", "Scheduler/Dispacher", "Other"
    ]
    var body: some View {
        ZStack{
            Image("Group 1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .center)
                .ignoresSafeArea()
            
            VStack(spacing: 50){
                    VStack(spacing: 24){
                        VStack {
                            Text("Info:")
                                .foregroundColor(Color.black)
                                .bold()
                                .font(.system(size: 20))
                            VStack(spacing: 5) {
                                CreateAccountComponent(textCreateAccount: $name, text: "FIRST AND LAST NAME")
                                //CreateAccountComponent(textCreateAccount: $homeAirport, text: "HOME AIRPORT")
                                
                                TextField("HOME AIRPORT", text: $homeAirport)
                                    .foregroundColor(Color.black)
                                    .autocapitalization(.allCharacters)
                                    .textCase(.uppercase)
                                    .font(.system(size: 20))
                                    .disableAutocorrection(true)
                                    .multilineTextAlignment(.center)
                                    .padding(.leading, 10)
                                    .frame(width: 300, height: 40)
                                    .background(Color(white: 0.90))
                                    .cornerRadius(10)
                                    .shadow(color: .gray, radius: 3, x: 0, y: 0)
                                CreateAccountComponent(textCreateAccount: $aircraftType, text: "AIRCRAFT TYPE")
                            }
                        }
                        VStack{
                            Text("Credentials:")
                                .foregroundColor(Color.black)
                                .bold()
                                .font(.system(size: 20))
                            VStack(spacing: 8) {
                                CreateAccountComponent(textCreateAccount: $email, text: "EMAIL ADDRESS")
                                CreateAccountComponent(textCreateAccount: $password, text: "PASSWORD")
                            }
                        }
                    }
                    .foregroundColor(Color.black)
                Rectangle()
                    //.fill(isFill() ? Color.black : Color.gray.opacity(0.5))
                    .fill(isFill() ? LinearGradient(gradient: Gradient(colors: [.white, Color(red: 135/255, green: 206/255, blue: 235/255, opacity: 1)]), startPoint: .leading, endPoint: .trailing) : LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.4), .gray.opacity(0.4)]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: 290, height: 65)
                    .cornerRadius(10)
                    .overlay(
                        Text("CREATE ACCOUNT")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(isFill() ? Color.black : Color(red: 200/255, green: 200/255, blue: 200/255, opacity: 1))
                    )
                    .shadow(color: .gray, radius: 3, x: 0, y: 0)
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                        save()
                    }
                    .disabled(!isFill())
                    //.padding(.bottom
                    Spacer()
            }
            .offset(y: 100)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                HStack {
                                    Image(systemName: "chevron.backward")
                                        .renderingMode(.original)
                                        .font(.title2)
                                        .foregroundColor(.black)
                                    Text("Back")
                                        .font(.title2)
                                        .foregroundColor(.black)
                                }
                                .onTapGesture {
                                    presentationMode.wrappedValue.dismiss()
                                })
    }
    
    func isFill() -> Bool{
        if name == ""{
            return false
        }
        if email == ""{
            return false
        }
        if homeAirport == ""{
            return false
        }
        if aircraftType == ""{
            return false
        }
        if password == ""{
            return false
        }
        return true
    }
    
    func save() {
        let db = Firestore.firestore()
        db.collection("account").document(name).setData(["firstAndLastName": name, "emailAddress": email, "password": password, "homeAirport": homeAirport, "aircraftType": aircraftType, "role": role])
    }
}

struct CreateAccountComponent: View
{
    @Binding var textCreateAccount: String
    var text: String
    var body: some View{
//        VStack(spacing: 7){
//            Text(text)
//                .font(.title)
//                .fontWeight(.bold)
//                .foregroundColor(.black)
//            Rectangle()
//                .fill(Color.white)
//                .frame(width: 270, height: 45)
//                .overlay(
//                    TextField("", text: $textCreateAccount)
//                        .autocapitalization(.none)
//                        .foregroundColor(Color.black)
//                        .padding(.leading)
//                        .font(.title2)
//                )
//                .border(Color.black, width: 2.5)
//        }
//        VStack {
//            HStack {
//                Text("\(text):")
//                    .bold()
//                    .font(.system(size: 20))
//            }
            
            TextField(text, text: $textCreateAccount)
                .foregroundColor(Color.black)
                .autocapitalization(.none)
                .font(.system(size: 20))
                .disableAutocorrection(true)
                .multilineTextAlignment(.center)
                .padding(.leading, 10)
                .frame(width: 300, height: 40)
                .background(Color(white: 0.90))
                .cornerRadius(10)
                .shadow(color: .gray, radius: 3, x: 0, y: 0)
        //}
    }
}

struct CreateAccount_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccount()
    }
}
