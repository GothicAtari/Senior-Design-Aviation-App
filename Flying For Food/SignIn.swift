//
//  SignIn.swift
//  Flying For Food
//
//  Created by Rice on 10/7/21.
//
import FirebaseFirestore
import SwiftUI

struct SignIn: View {
    @State var emailAddress: String = ""
    @State var password: String = ""
    @State var isAnimation: Bool = false
    @State var incorrectAccount = false
    @State var tooManyAttempts = false
    @State var attempt = 0
    @StateObject var accountCollection = accountViewModel()
    @State private var isShowingFrontPage = false
    var body: some View {
        ZStack{
            Image("Group 1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .center)
                .ignoresSafeArea()
            wholeBody
            //.animation(isAnimation ? .easeInOut(duration: 1.0) : nil)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    private var SignInButton: some View{
        Rectangle()
        //         .fill(accountCollection.isNotNull(email: emailAddress, password: password) ? Color.black : Color.gray.opacity(0.5))
        //            .frame(width: 180, height: 65)
        //            .cornerRadius(19)
        //            .overlay(
        //                Text("Sign In")
        //                    .font(.title)
        //                    .fontWeight(.bold)
        //                    .foregroundColor(accountCollection.isNotNull(email: emailAddress, password: password) ? Color.white : Color.white.opacity(0.5))
        //            )
            .fill(accountCollection.isNotNull(email: emailAddress, password: password) ? LinearGradient(gradient: Gradient(colors: [.white, Color(red: 135/255, green: 206/255, blue: 235/255, opacity: 1)]), startPoint: .leading, endPoint: .trailing) : LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.4), .gray.opacity(0.4)]), startPoint: .leading, endPoint: .trailing))
            .frame(width: 180, height: 65)
            .cornerRadius(19)
            .overlay(
                HStack {
                    Text("Sign In")
                        .foregroundColor(accountCollection.isNotNull(email: emailAddress, password: password) ? Color.black : Color(red: 200/255, green: 200/255, blue: 200/255, opacity: 1))
                        .font(.title)
                        .fontWeight(.bold)
                    Image(systemName: "arrow.right")
                        .foregroundColor(accountCollection.isNotNull(email: emailAddress, password: password) ? .black : Color(red: 200/255, green: 200/255, blue: 200/255, opacity: 1))
                }
            )
            .cornerRadius(10)
            .shadow(color: .gray, radius: 3, x: 0, y: 0)
    }
    
    private var wholeBody: some View{
        VStack(spacing: 10){
            Spacer()
            Spacer()
            VStack(spacing: 25){
                HStack {
                    Text("Login")
                        .foregroundColor(Color.black)
                        .font(.system(size: 40))
                        .bold()
                    Spacer()
                }
                .padding()
                emailTextfield(textSignIn: $emailAddress, isEmailAnimation: $isAnimation, text: "EMAIL ADDRESS")
                passwordTextfield(textSignIn: $password, isPasswordAnimation: $isAnimation, text: "PASSWORD")
                if incorrectAccount {
                    errorMessage(text: "Incorrect email or password. Try again.")
                }
                if tooManyAttempts {
                    VStack{
                        Text("Forgot password?")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color.red)
                        HStack(spacing: 0){
                            Text("Click ")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(Color.red)
                            NavigationLink(
                                destination: CreateAccount(),
                                label: {
                                    Text("HERE")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.red)
                                        .bold()
                                        .underline()
                                })
                                .background(Color.clear)
                            Text(" to create a new account.")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(Color.red)
                        }
                    }
                }
                //mine
                HStack {
                    Spacer()
                    ZStack {
                        NavigationLink(destination: FrontPage(), isActive: $isShowingFrontPage)
                        {
                            EmptyView()
                        }
                        .background(Color.clear)
                        //
                        Button(action: {
                            if (accountCollection.isCorrectAccount(email: emailAddress, password: password)) {
                                UserDefaults.standard.set(1, forKey: "isSignPage")
                                isShowingFrontPage = true
                                if let account = accountViewModel.textCorrespondingAccount {
                                    UserDefaults.standard.set(account.role, forKey: "role")
                                    UserDefaults.standard.set(account.firstAndLastName, forKey: "name")
                                }
                            }
                            else {
                                incorrectAccount = true
                                attempt += 1
                                if attempt > 5 {
                                    tooManyAttempts = true
                                }
                            }
                        }, label: {
                            SignInButton
                        })
                            .disabled(!accountCollection.isNotNull(email: emailAddress, password: password))
                            .background(Color.clear)
                    }
                }
                .padding(.trailing)
                
                //
                
//                if (accountCollection.isNotNull(email: emailAddress, password: password)) {
//                    //problem is that this is causing it to move
//                    NavigationLink(destination: WelcomePage(), isActive: $isShowingFrontPage)
//                    {
//                        EmptyView()
//                    }
//                    //
//                    Button(action: {
//                        if (accountCollection.isCorrectAccount(email: emailAddress, password: password)) {
//                            UserDefaults.standard.set(1, forKey: "isSignPage")
//                            isShowingFrontPage = true
//                            if let account = accountViewModel.textCorrespondingAccount {
//                                UserDefaults.standard.set(account.role, forKey: "role")
//                            }
//                        }
//                        else {
//                            var body: some View {
//                                VStack(spacing: 100) {
//                                    errorMessage(text: "incorrect email or password")
//                                }
//                            }
//                        }
//                    }, label: {
//                        SignInButton
//                    })
//                }
//                else{
//                    Button(action: {}, label: {
//                        SignInButton
//                    })
//                        .disabled(!accountCollection.isCorrectAccount(email: emailAddress, password: password))
//                }
                
            }
            VStack{
                Text("Don't have an account?")
                    .foregroundColor(Color.gray)
                HStack(spacing: 0){
                    Text("Click ")
                        .foregroundColor(Color.gray)
                    NavigationLink(
                        destination: CreateAccount(),
                        label: {
                            Text("HERE")
                                .foregroundColor(Color.gray)
                                .bold()
                                .underline()
                        })
                        .background(Color.clear)
                    Text(" to create one.")
                        .foregroundColor(Color.gray)
                }
            }
            Spacer()
        }
        //.animation(isAnimation ? .easeInOut(duration: 1.0) : nil)
    }
}

struct emailTextfield: View
{
    @Binding var textSignIn: String
    @Binding var isEmailAnimation: Bool
    var text: String
    var body: some View{
        //        VStack(spacing: 9) {
        //        Text(text)
        //            .font(.title3)
        //            .fontWeight(.bold)
        //            .foregroundColor(.black)
        //        Rectangle()
        //            .fill(Color.white)
        //            .frame(width: 290, height: 45)
        //            .overlay(
        //                TextField("", text: $textSignIn)
        //                    .foregroundColor(Color.black)
        //                    .padding(.leading)
        //                    .font(.title2)
        //                    .onTapGesture {
        //                        isEmailAnimation = true
        //                    }
        //            )
        //            .border(Color.black, width: 1.5)
        //        }
        TextField("Email Address", text: $textSignIn)
            .foregroundColor(Color.black)
            .autocapitalization(.none)
            .textCase(.uppercase)
            .font(.system(size: 20))
            .disableAutocorrection(true)
            .multilineTextAlignment(.center)
            .padding(.leading, 10)
            .frame(width: 300, height: 60)
            .background(Color(white: 0.90))
            .onTapGesture {
                isEmailAnimation = true
            }
            .cornerRadius(10)
            .shadow(color: .gray, radius: 3, x: 0, y: 0)
    }
}

struct passwordTextfield: View
{
    @Binding var textSignIn: String
    @Binding var isPasswordAnimation: Bool
    var text: String
    var body: some View{
        //        VStack(spacing: 9) {
        //        Text(text)
        //            .font(.title3)
        //            .fontWeight(.bold)
        //            .foregroundColor(.black)
        //        Rectangle()
        //            .fill(Color.white)
        //            .frame(width: 290, height: 45)
        //            .overlay(
        //                SecureField("", text: $textSignIn)
        //                    .foregroundColor(Color.black)
        //                    .padding(.leading)
        //                    .font(.title2)
        //                    .onTapGesture {
        //                        isPasswordAnimation = true
        //                    }
        //            )
        //            .border(Color.black, width: 1.5)
        //        }
        SecureField("Password", text: $textSignIn)
            .foregroundColor(Color.black)
            .autocapitalization(.none)
            .textCase(.uppercase)
            .font(.system(size: 20))
            .disableAutocorrection(true)
            .multilineTextAlignment(.center)
            .padding(.leading, 10)
            .frame(width: 300, height: 60)
            .background(Color(white: 0.90))
            .onTapGesture {
                isPasswordAnimation = true
            }
            .cornerRadius(10)
            .shadow(color: .gray, radius: 3, x: 0, y: 0)
    }
}

struct errorMessage: View {
    
    var text: String
    var body: some View {
        VStack(spacing: 5) {
            Text(text)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.red)
        }
    }
    
    
    
}



struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
    }
}
