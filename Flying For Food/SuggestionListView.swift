//
//  SuggestionListView.swift
//  Flying For Food
//
//  Created by Kyle Davis on 2/18/22.
//

import SwiftUI

struct SuggestionListView: View {
    
    var suggColl: SuggestionCollection
    @StateObject var aviationModel = aviationViewModel()
    @StateObject var reviewModel = reviewViewModel()
    @State var addActive: Bool = false
    @State var breakfastSelected: Bool = false
    @State var lunchSelected: Bool = false
    @State var dinnerSelected: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color(red: 165/255, green: 236/255, blue: 255/255, opacity: 0.7)
                .ignoresSafeArea()
            VStack {
                Text(suggColl.restaurantName != "" ? suggColl.restaurantName : "No restaurant").font(.system(size: 25, weight: .bold)).foregroundColor(Color.black).multilineTextAlignment(.center)
                Text(suggColl.IDENT != "" ? suggColl.IDENT : "No identifier").font(.system(size: 25, weight: .bold)).foregroundColor(Color.black).multilineTextAlignment(.center)
                Text("Suggestions").font(.system(size: 25, weight: .bold)).foregroundColor(Color.black).multilineTextAlignment(.center)
                if addActive {
                    VStack {
                        HStack {
                            Toggle(isOn: $breakfastSelected, label: {
                                Text("Breakfast")
                            })
                                .toggleStyle(MyToggleStyle())
                            Toggle(isOn: $lunchSelected, label: {
                                Text("Lunch")
                            })
                                .toggleStyle(MyToggleStyle())
                            Toggle(isOn: $dinnerSelected, label: {
                                Text("Dinner")
                            })
                                .toggleStyle(MyToggleStyle())
                        }
                        HStack {
                            Button(action: {
                                addRest(breakfastSelected: breakfastSelected, lunchSelected: lunchSelected, dinnerSelected: dinnerSelected, name: suggColl.restaurantName, identifier: suggColl.IDENT)
                                breakfastSelected = false
                                lunchSelected = false
                                dinnerSelected = false
                                addActive = false
                            }, label: {
                                Rectangle()
                                    .fill(
                                        LinearGradient(gradient: Gradient(colors: [.white, Color(red: 135/255, green: 206/255, blue: 235/255, opacity: 1)]), startPoint: .leading, endPoint: .trailing)
                                    )
                                    .frame(minWidth: 50, maxWidth: 50, minHeight: 30, idealHeight: 30, maxHeight: 30)
                                    .overlay(
                                        Text("Add")
                                            .bold()
                                            .foregroundColor(.black)
                                    )
                                    .cornerRadius(3)
                                    .shadow(color: .gray, radius: 3, x: 0, y: 0)
                            })
                            Button(action: {
                                breakfastSelected = false
                                lunchSelected = false
                                dinnerSelected = false
                                addActive = false
                            }, label: {
                                Rectangle()
                                    .fill(
                                        LinearGradient(gradient: Gradient(colors: [.white, Color(red: 135/255, green: 206/255, blue: 235/255, opacity: 1)]), startPoint: .leading, endPoint: .trailing)
                                    )
                                    .frame(minWidth: 70, maxWidth: 70, minHeight: 30, idealHeight: 30, maxHeight: 30)
                                    .overlay(
                                        Text("Cancel")
                                            .bold()
                                            .foregroundColor(.black)
                                    )
                                    .cornerRadius(3)
                                    .shadow(color: .gray, radius: 2, x: 0, y: 0)
                            })
                        }
                    }
                }
                else {
                    HStack {
                        Spacer()
                        Button(action: {
                            addActive = true
                        }, label: {
                            Rectangle()
                                .fill(
                                    LinearGradient(gradient: Gradient(colors: [.white, Color(red: 135/255, green: 206/255, blue: 235/255, opacity: 1)]), startPoint: .leading, endPoint: .trailing)
                                )
                                .frame(minWidth: 200, maxWidth: 200, minHeight: 30, idealHeight: 30, maxHeight: 30)
                                .overlay(
                                    Text("Quick Add Restaurant")
                                        .bold()
                                        .foregroundColor(.black)
                                )
                                .cornerRadius(3)
                                .shadow(color: .gray, radius: 2, x: 0, y: 0)
                                .padding(.horizontal, 4)
                        })
                    }
                }
                List(suggColl.suggestions) { sugg in
                    NavigationLink {
                        SuggestionIndivView(sugg: sugg)
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(sugg.restaurantName != "" ? sugg.restaurantName : "No restaurant")
                                Text(sugg.IDENT != "" ? sugg.IDENT : "No airport")
                            }
                            Spacer()
                            Text(sugg.firstLastName != "" ? sugg.firstLastName : "No name")
                        }
                    }
                }
                //}
                .cornerRadius(10)
                //.padding(1)
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
    
    func getSuggestions() -> [suggestion] {
        return suggColl.suggestions
    }
    
    func addRest(breakfastSelected: Bool, lunchSelected: Bool, dinnerSelected: Bool, name: String, identifier: String) {
        if breakfastSelected || lunchSelected || dinnerSelected {
            aviationModel.addRestFromSuggs(breakfastSelected: breakfastSelected, lunchSelected: lunchSelected, dinnerSelected: dinnerSelected, name: name, identifier: identifier)
            reviewModel.addRevFromSuggs(name: name, identifier: identifier, suggCount: suggColl.suggestions.count)
        }
    }
}

struct MyToggleStyle: ToggleStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        Rectangle()
        .fill(
            LinearGradient(gradient: Gradient(colors: [.white, Color(red: 135/255, green: 206/255, blue: 235/255, opacity: 1)]), startPoint: .leading, endPoint: .trailing))
        .frame(minWidth: 110, maxWidth: 110, minHeight: 30, idealHeight: 30, maxHeight: 30)
        .overlay(
            HStack {
                HStack {
                    configuration.label
                    Image(systemName: configuration.isOn ? "checkmark.square.fill" : "squareshape.fill")
                        .foregroundColor(configuration.isOn ? Color(UIColor.systemBlue) : Color.white)
                }
                .padding(4)
            }
        )
        .cornerRadius(3)
        .shadow(color: .gray, radius: 2, x: 0, y: 0)
        .padding(3)
        .onTapGesture { configuration.isOn.toggle() }
    }
    
}

//struct SuggestionListView_Previews: PreviewProvider {
//    static var previews: some View {
//        SuggestionListView()
//    }
//}
