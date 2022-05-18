//
//  TrackerRestaurants.swift
//  Flying For Food
//
//  Created by Kyle Davis on 4/12/22.
//

import SwiftUI
import FirebaseFirestore

struct TrackerRestaurants: View {
    var airIdent: String
    var mealType: String
    var testBool: Bool = true
    @State var isDeleteActive: Bool = false
    @StateObject var aviationModel = aviationViewModel()
    @StateObject var reviewModel = reviewViewModel()
    @State private var isConfirmation = false
    @State private var reviewToDel: review = review()
    
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color(red: 165/255, green: 236/255, blue: 255/255, opacity: 0.7)
                .ignoresSafeArea()
            VStack {
                Text(airIdent)
                    .font(.system(size: 25, weight: .bold)).foregroundColor(Color.black).multilineTextAlignment(.center)
                Text(mealType)
                    .font(.system(size: 25)).foregroundColor(Color.black).multilineTextAlignment(.center)
                Text("Restaurants")
                    .font(.system(size: 25)).foregroundColor(Color.black).multilineTextAlignment(.center)
                if getReviews().count != 0 {
                    HStack {
                        Spacer()
                        if !isDeleteActive {
                            Button(action: {
                                isDeleteActive = true
                            }, label: {
                                Rectangle()
                                    .fill(
                                        LinearGradient(gradient: Gradient(colors: [.white, Color(red: 135/255, green: 206/255, blue: 235/255, opacity: 1)]), startPoint: .leading, endPoint: .trailing)
                                    )
                                    .frame(minWidth: 160, maxWidth: 160, minHeight: 30, idealHeight: 30, maxHeight: 30)
                                    .overlay(
                                        Text("Delete Restaurants")
                                            .bold()
                                            .foregroundColor(.black)
                                    )
                                    .cornerRadius(3)
                                    .shadow(color: .gray, radius: 2, x: 0, y: 0)
                                    .padding(.horizontal, 4)
                            })
                        } else {
                            Button(action: {
                                isDeleteActive = false
                            }, label: {
                                Rectangle()
                                    .fill(
                                        LinearGradient(gradient: Gradient(colors: [.white, Color(red: 135/255, green: 206/255, blue: 235/255, opacity: 1)]), startPoint: .leading, endPoint: .trailing)
                                    )
                                //.frame(width: width, height: 45)
                                    .frame(minWidth: 100, maxWidth: 100, minHeight: 30, idealHeight: 30, maxHeight: 30)
                                    .overlay(
                                        Text("Cancel")
                                            .bold()
                                            .foregroundColor(.black)
                                    )
                                    .cornerRadius(3)
                                    .shadow(color: .gray, radius: 2, x: 0, y: 0)
                                    .padding(.horizontal, 4)
                            })
                        }
                    }
                    .padding(.horizontal)
                }
                List{
                    //Section(header: groupedListHeader, footer: EmptyView()) {
                    //if !(reviews.isEmpty) {
                    if !isDeleteActive {
                        ForEach(getReviews(), id: \.id) { rev in
                            NavigationLink(destination: TrackerRestaurantIndivView(review: rev, mealType: mealType))
                            {
                                HStack {
                                    Spacer()
                                    Text(rev.restaurant != "" ? rev.restaurant : "No restaurant")
                                        .lineLimit(1)
                                    Spacer()
                                }
                                .foregroundColor(Color.black)
                                .listRowBackground(Color(white: 0.5))
                            }
                        }
                        if getReviews().count == 0 {
                            HStack{
                                Spacer()
                                Text("No restaurants")
                                    .foregroundColor(Color.gray)
                                    .bold()
                                Spacer()
                            }
                        }
                    } else {
                        ForEach(getReviews(), id: \.id) { rev in
                            HStack {
                                Spacer()
                                Text(rev.restaurant != "" ? rev.restaurant : "No restaurant")
                                    .lineLimit(1)
                                Spacer()
                                Button {
                                    self.reviewToDel = rev
                                    self.isConfirmation = true
                                } label: {
                                    Image(systemName: "x.square.fill")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(Color.red)
                                        .shadow(color: .gray, radius: 3, x: 0, y: 0)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                            .foregroundColor(Color.black)
                            .background(Color.white)
                        }
                        .alert(isPresented: $isConfirmation) {
                            Alert(title: Text("Delete " + reviewToDel.restaurant), message: Text("Are you sure?"),
                                primaryButton: .destructive(
                                    Text("Delete"),
                                    action: {
                                        delete(revDel: reviewToDel)
                                        isConfirmation = false
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                ),
                                  secondaryButton: .cancel(
                                    Text("Cancel"),
                                    action: {
                                        isConfirmation = false
                                    }
                                )
                            )
                        }
                        if getReviews().count == 0 {
                            HStack{
                                Spacer()
                                Text("No restaurants")
                                    .foregroundColor(Color.gray)
                                    .bold()
                                Spacer()
                            }
                        }
                    }
                }
                .listStyle(DefaultListStyle())
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
    
    func getReviews() -> [review] {
        var reviewArray: [review] = []
        
        if aviationModel.isSpecificData(ident: airIdent) {
            if let airport = aviationViewModel.textCorrespondingAvia {
                
                if mealType == "Breakfast" {
                    let breakfastOptions = airport.Breakfast.components(separatedBy: "; ")
                    for breakfastOpt in breakfastOptions {
                        if breakfastOpt != "" {
                            reviewArray.append(reviewModel.getReview(Ident: airIdent, restaurant: breakfastOpt))
                        }
                    }
                }
                if mealType == "Lunch" {
                    let lunchOptions = airport.Lunch.components(separatedBy: "; ")
                    for lunchOpt in lunchOptions {
                        if lunchOpt != "" {
                            reviewArray.append(reviewModel.getReview(Ident: airIdent, restaurant: lunchOpt))
                        }
                    }
                }
                if mealType == "Dinner" {
                    let dinnerOptions = airport.Dinner.components(separatedBy: "; ")
                    for dinnerOpt in dinnerOptions {
                        if dinnerOpt != "" {
                            reviewArray.append(reviewModel.getReview(Ident: airIdent, restaurant: dinnerOpt))
                        }
                    }
                }
                reviewArray = sortReviews(reviewArray: reviewArray)
            }
        }
        return reviewArray
    }
    
    func delete(revDel: review) {
        if !aviationModel.isInMultipleMealTypes(name: revDel.restaurant, identifier: revDel.IDENT) {
            if reviewModel.isExisting(Ident: revDel.IDENT, restaurant: revDel.restaurant) {
                reviewModel.deleteReview(name: revDel.restaurant, identifer: revDel.IDENT)
            }
        }
        aviationModel.deleteRestaurant(name: revDel.restaurant, identifier: revDel.IDENT, mealType: mealType)
        
    }
    
    func sortReviews(reviewArray: [review]) -> [review] {
        var sortedReviews: [review] = []
        sortedReviews = reviewArray.sorted(by: { rev1, rev2 in
            (rev1.thumbsUpCount - rev1.thumbsDownCount) > (rev2.thumbsUpCount - rev2.thumbsDownCount)
        })
        return sortedReviews
    }
}

//struct TrackerRestaurants_Previews: PreviewProvider {
//    static var previews: some View {
//        TrackerRestaurants()
//    }
//}
