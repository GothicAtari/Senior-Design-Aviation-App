//
//  Options.swift
//  Flying For Food
//
//  Created by Rice on 10/8/21.
//

import SwiftUI

struct Options: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isShowingSignIn = false
    var body: some View {
        ZStack{
            Image("Group 1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .center)
                .ignoresSafeArea()
            
            VStack(spacing : 200){
                Spacer()
                VStack(spacing: 30){
                    NavigationLink(
                        destination: Suggestion(),
                        label: {
                            rectangularStyle(text: "MAKE A SUGGESTION")
                        })
                    NavigationLink(
                        destination: BlurbPage(),
                        label: {
                            rectangularStyle(text: "ABOUT US")
                        })
                    
                    NavigationLink(
                        destination: ContactUsPage(),
                        label: {
                            rectangularStyle(text: "CONTACT US")
                        })
                    if let role = UserDefaults.standard.string(forKey: "role") {
                        if role == "admin" {
                            NavigationLink(
                                destination: AdminMenu(),
                                label: {
                                    rectangularStyle(text: "ADMIN")
                                })
                        }
                    }
                    ZStack {
                        NavigationLink(destination: SignIn()
                                       , isActive: $isShowingSignIn)
                        {
                            EmptyView()
                        }
                        .background(Color.clear)
                        Button(action: {
                            UserDefaults.standard.set(0, forKey: "isSignPage")
                            UserDefaults.standard.set("", forKey: "role")
                            isShowingSignIn = true
                        }, label: {
                            rectangularStyle(text: "SIGN OUT")
                        })
                        .background(Color.clear)
                    }
                    
                    Spacer()
                }
                Spacer()
            }
            .offset(y: 75)
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
}

struct rectangularStyle: View{
    var text: String
    var body: some View{
        Rectangle()
            .fill(LinearGradient(gradient: Gradient(colors: [Color.white, Color("skyblue")]), startPoint: .leading, endPoint: .trailing))
            .frame(width: 200, height: 60)
            .overlay(
                Text(text)
                    .font(.body)
                    .foregroundColor(Color.black)
                    .fontWeight(.semibold)
            )
            .cornerRadius(15)
            .shadow(color:.black.opacity(0.25), radius: 2, x: 2, y: 10)
    }
}

struct Options_Previews: PreviewProvider {
    static var previews: some View {
        Options()
    }
}
