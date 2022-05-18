//
//  AdminSuggestionPage.swift
//  Flying For Food
//
//  Created by Kyle Davis on 2/18/22.
//

import SwiftUI
import UIKit

struct AdminSuggestionPage: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var suggestionModel = suggestionViewModel()
    @StateObject var avModel = aviationViewModel()
    @State var filterIdent: String = "All"
    
    init () {
        UITableView.appearance().backgroundColor = .white
        UITableView.appearance().separatorColor = .black
    }
    var body: some View {
        ZStack{
            Color(red: 165/255, green: 236/255, blue: 255/255, opacity: 0.7)
                .ignoresSafeArea()
            

            VStack {
                Text("Suggestions").font(.system(size: 30, weight: .bold)).foregroundColor(Color.black).multilineTextAlignment(.center)
                HStack {
                    Menu {
                        Button {
                            filterIdent = "All"
                            } label: {
                                Text("All")
                            }
                        ForEach(avModel.getAirportIdents(), id: \.self) { airIdent in
                            Button {
                                    filterIdent = airIdent
                                } label: {
                                    Text(airIdent)
                                }
                        }
                    } label: {
                        Rectangle()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.white, Color("skyblue")]), startPoint: .leading, endPoint: .trailing))
                            .frame(width: 100, height: 30)
                            .overlay(
                                HStack {
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(Color.black)
                                    Text(filterIdent)
                                        .font(.body)
                                        .foregroundColor(Color.black)
                                        .fontWeight(.semibold)
                                }
                            )
                            .cornerRadius(5)
                            .shadow(color:.black.opacity(0.25), radius: 2.5, x: 0, y: 0)
                   }
                    Spacer()
                }
                .padding(1)
                .padding(.leading, 6)
                List{
                    //Section(header: groupedListHeader, footer: EmptyView()) {
                    if suggestionModel.getSuggestions(airportIdent: filterIdent).count != 0 {
                        ForEach(suggestionModel.getSuggestions(airportIdent: filterIdent), id: \.id) { suggColl in
                            NavigationLink(destination: SuggestionListView(suggColl: suggColl))
                            {
                                HStack {
                                    Text(suggColl.restaurantName != "" ? suggColl.restaurantName : "No restaurant")
                                        .lineLimit(1)
                                    Spacer()
                                    Text(suggColl.IDENT != "" ? suggColl.IDENT : "No airport")
                                        //.padding(.trailing)
                                    Text(String(suggColl.suggestions.count))

                                }
                                .foregroundColor(Color.black)
                                .listRowBackground(Color(white: 0.5))
                            }
                        }
                    } else {
                        HStack{
                            Spacer()
                            Text("No suggestions")
                                .foregroundColor(Color.gray)
                                .bold()
                            Spacer()
                        }
                    }
                }
                .listStyle(DefaultListStyle())
                .cornerRadius(10)
                .frame(maxWidth: 380, maxHeight: 600)
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
    
    var groupedListHeader: some View {
        HStack {
            Image(systemName: "tray.full.fill")
            Text("All Posts from The Happy Programmer")
        }
    }
}



struct AdminSuggestionPage_Previews: PreviewProvider {
    static var previews: some View {
        AdminSuggestionPage()
    }
}
