//
//  SuggestionIndivView.swift
//  Flying For Food
//
//  Created by Kyle Davis on 2/18/22.
//

import SwiftUI

struct SuggestionIndivView: View {
    
    var sugg: suggestion
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color(red: 165/255, green: 236/255, blue: 255/255, opacity: 0.7)
                .ignoresSafeArea()
            VStack {
                VStack(alignment: .leading) {
                    Text("Restaurant Name:")
                        .bold()
                        .font(.system(size: 25))
                    Text(sugg.restaurantName != "" ? sugg.restaurantName: "No restaurant")
                        .font(.system(size: 18))
                        .padding(.horizontal)
                        .padding(.top, 1)
                    Divider()
                }
                .padding(2)
                .padding(.horizontal)
                VStack(alignment: .leading) {
                    Text("Airport Identifer:")
                        .bold()
                        .font(.system(size: 25))
                    Text(sugg.IDENT != "" ? sugg.IDENT: "No airport")
                        .font(.system(size: 18))
                        .padding(.horizontal)
                        .padding(.top, 1)
                    Divider()
                }
                .padding(2)
                .padding(.horizontal)
                VStack(alignment: .leading) {
                    Text("User:")
                        .bold()
                        .font(.system(size: 25))
                    Text(sugg.firstLastName != "" ? sugg.firstLastName: "No name")
                        .font(.system(size: 18))
                        .padding(.horizontal)
                        .padding(.top, 1)
                    Divider()
                }
                .padding(2)
                .padding(.horizontal)
                VStack(alignment: .leading) {
                    Text("Meal Type:")
                        .bold()
                        .font(.system(size: 25))
                    Text(sugg.typeOfMeal != "" ? sugg.typeOfMeal.replacingOccurrences(of: "&", with: " & "): "No meal type")
                        .font(.system(size: 18))
                        .padding(.horizontal)
                        .padding(.top, 1)
                    Divider()
                }
                .padding(2)
                .padding(.horizontal)
                VStack(alignment: .leading) {
                    Text("Comment:")
                        .bold()
                        .font(.system(size: 25))
                    Text(sugg.comment != "" ? sugg.comment: "No comment")
                        .font(.system(size: 18))
                        .padding(.horizontal)
                        .padding(.top, 1)
                    Divider()
                }
                .padding(.horizontal)
                .padding(2)
                
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

//struct SuggestionIndivView_Previews: PreviewProvider {
//    static var previews: some View {
//        SuggestionIndivView()
//    }
//}
