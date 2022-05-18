//
//  AddAdminPage.swift
//  Flying For Food
//
//  Created by Kyle Davis on 2/16/22.
//

import SwiftUI

struct AddAdminPage: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var accountCollection = accountViewModel()
    @State var email: String = ""
    @State var success: Bool = false
    @State var showingOutput: Bool = false
    var body: some View {
        ZStack{
            Image("Group 1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .center)
                .ignoresSafeArea()
            
            VStack(spacing : 85){
                Spacer()
                VStack(spacing: 30){
                    Text("Email of user to be upgraded:").font(.system(size: 20, weight: .bold)).foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5))).multilineTextAlignment(.center)
                    //CreateAccountComponent(textCreateAccount: $email, text: "EMAIL ADDRESS")
                    TextField("Email Address", text: $email)
                        .font(.system(size: 20))
                        .disableAutocorrection(true)
                        .multilineTextAlignment(.center)
                        .padding(.leading, 10)
                        .frame(width: 300, height: 60)
                        .background(Color(white: 0.90))
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 3, x: 0, y: 0)
                }
                Button(action: {
                    if isFill() {
                        if accountCollection.upgradeAccount(email: email) {
                            success = true
                            showingOutput = true
                        } else {
                            success = false
                            showingOutput = true
                        }
                    }
                    //presentationMode.wrappedValue.dismiss()
                }, label: {
//                    Rectangle()
//                        .fill(Color.black)
//                        .opacity(0.75)
//                        .frame(width: 100, height: 40)
//                        .overlay(
//                            Text("Submit")
//                            .font(.title2)
//                            .foregroundColor(.white)
//                            .fontWeight(.bold)
//                        )
//                        .cornerRadius(7)
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [.white, Color(red: 135/255, green: 206/255, blue: 235/255, opacity: 1)]), startPoint: .leading, endPoint: .trailing))
                        .frame(width: 150, height: 55)
                        .overlay(
                            Text("SUBMIT")
                                .foregroundColor(Color.black)
                                .font(.title2)
                                .fontWeight(.semibold)
                        )
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 3, x: 0, y: 0)
                })
                if showingOutput {
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color.black)
                            .frame(width: 200, height: 60)
                        if success {
                            Text("Admin User Added")
                                .foregroundColor(Color.white)
                        }
                        else {
                            Text("Account Does Not Exist")
                                .foregroundColor(Color.white)
                        }
                    }
                }
                Spacer()
            }
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
        if email == ""{
            return false
        }
        return true
    }
}

struct AddAdminPage_Previews: PreviewProvider {
    static var previews: some View {
        AddAdminPage()
    }
}
