//
//  AdminMenu.swift
//  Flying For Food
//
//  Created by Kyle Davis on 2/11/22.
//

import SwiftUI

struct AdminMenu: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isShowingSignIn = false
    var body: some View {
        ZStack{
            Image("Group 1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .center)
                .ignoresSafeArea()
            
            VStack(spacing : 85){
                Spacer()
                VStack(spacing: 20){
                    NavigationLink(
                        destination: AddAdminPage(),
                        label: {
                            rectangularStyle(text: "ADD ADMIN USER")
                        })
                    NavigationLink(
                        destination: AddRestaurantPage(),
                        label: {
                            rectangularStyle(text: "ADD RESTAURANT")
                        })
                    NavigationLink(
                        destination: AdminSuggestionPage(),
                        label: {
                            rectangularStyle(text: "USER SUGGESTIONS")
                        })
                    NavigationLink(
                        destination: AppInfoPage(),
                        label: {
                            rectangularStyle(text: "APP INFO")
                        })
                    NavigationLink(
                        destination: LikeDislikeTracker(),
                        label: {
                            rectangularStyle(text: "MANAGE RESTAURANTS")
                        })
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
}

struct AdminMenu_Previews: PreviewProvider {
    static var previews: some View {
        AdminMenu()
    }
}
