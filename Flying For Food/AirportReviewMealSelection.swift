//
//  AirportReviewMealSelection.swift
//  Flying For Food
//
//  Created by Kyle Davis on 4/12/22.
//

import SwiftUI

struct AirportReviewMealSelection: View {
    var airportIdent: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack{
            Color(red: 165/255, green: 236/255, blue: 255/255, opacity: 0.7)
                .ignoresSafeArea()
            VStack(spacing: 22) {
                VStack {
                    Text(airportIdent)
                        .font(.system(size: 25, weight: .bold)).foregroundColor(Color.black).multilineTextAlignment(.center)
                    Text("Restaurants")
                        .font(.system(size: 25)).foregroundColor(Color.black).multilineTextAlignment(.center)
                }
                NavigationLink(
                    destination: TrackerRestaurants(airIdent: airportIdent, mealType: "Breakfast"),
                    label: {
                        rectangularStyle(text: "Breakfast")
                    })
                NavigationLink(
                    destination: TrackerRestaurants(airIdent: airportIdent, mealType: "Lunch"),
                    label: {
                        rectangularStyle(text: "Lunch")
                    })
                
                NavigationLink(
                    destination: TrackerRestaurants(airIdent: airportIdent, mealType: "Dinner"),
                    label: {
                        rectangularStyle(text: "Dinner")
                    })
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
    
    func sortReviews(reviews: [review]) -> [review] {
        var sortedReviews: [review] = []
        sortedReviews = reviews.sorted(by: { rev1, rev2 in
            (rev1.thumbsUpCount - rev1.thumbsDownCount) > (rev2.thumbsUpCount - rev2.thumbsDownCount)
        })
        return sortedReviews
    }
}

//struct AirportReviewMealSelection_Previews: PreviewProvider {
//    static var previews: some View {
//        AirportReviewMealSelection()
//    }
//}
