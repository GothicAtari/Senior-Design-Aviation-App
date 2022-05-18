//
//  LikeDislikeTracker.swift
//  Flying For Food
//
//  Created by Kyle Davis on 4/12/22.
//

import SwiftUI

struct LikeDislikeTracker: View {
    @StateObject var aviationModel = aviationViewModel()
    @StateObject var reviewModel = reviewViewModel()
    var revAirReviewColls: [airportReviewColls] = []
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack{
            Color(red: 165/255, green: 236/255, blue: 255/255, opacity: 0.7)
                .ignoresSafeArea()
            VStack {
                Text("Restaurant Manager").font(.system(size: 30, weight: .bold)).foregroundColor(Color.black).multilineTextAlignment(.center)
                Text("Select airport:").font(.system(size: 20, weight: .bold)).foregroundColor(Color.gray).multilineTextAlignment(.center)
                List{
                    //Section(header: groupedListHeader, footer: EmptyView()) {
                    //ForEach(getReviewCollections(), id: \.id) { airRevColl in
                    ForEach(aviationModel.getAirportIdents(), id: \.self) { airportIdent in
                        NavigationLink(destination: AirportReviewMealSelection(airportIdent: airportIdent))
                        {
                            HStack {
                                Spacer()
                                Text(airportIdent != "" ? airportIdent : "No identifier")
                                    .lineLimit(1)
                                Spacer()
                            }
                            .foregroundColor(Color.black)
                            .listRowBackground(Color(white: 0.5))
                        }
                    }
                    //}
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
    
    func getReviewCollections() -> [airportReviewColls] {
        
        var revAirReviewColls: [airportReviewColls] = []
        
        for airport in aviationModel.aviations {
            
            let breakfastColl: reviewCollection = reviewCollection()
            let lunchColl: reviewCollection = reviewCollection()
            let dinnerColl: reviewCollection = reviewCollection()
            var revAirColl: airportReviewColls = airportReviewColls(breakfastCollection: breakfastColl, lunchCollection: lunchColl, dinnerCollection: dinnerColl)
            
            revAirColl.IDENT = airport.IDENT
            revAirColl.breakfastCollection.IDENT = airport.IDENT
            revAirColl.lunchCollection.IDENT = airport.IDENT
            revAirColl.dinnerCollection.IDENT = airport.IDENT
            
            
            let breakfastOptions = airport.Breakfast.components(separatedBy: "; ")
            let lunchOptions = airport.Lunch.components(separatedBy: "; ")
            let dinnerOptions = airport.Dinner.components(separatedBy: "; ")
            
            for breakfastOpt in breakfastOptions {
                if breakfastOpt != "" {
                    revAirColl.breakfastCollection.reviews.append(reviewModel.getReview(Ident: airport.IDENT, restaurant: breakfastOpt))
                }
            }
            for lunchOpt in lunchOptions {
                if lunchOpt != "" {
                    revAirColl.lunchCollection.reviews.append(reviewModel.getReview(Ident: airport.IDENT, restaurant: lunchOpt))
                }
            }
            for dinnerOpt in dinnerOptions {
                if dinnerOpt != "" {
                    revAirColl.dinnerCollection.reviews.append(reviewModel.getReview(Ident: airport.IDENT, restaurant: dinnerOpt))
                }
            }
            revAirReviewColls.append(revAirColl)
        }
        return revAirReviewColls
    }
}

struct LikeDislikeTracker_Previews: PreviewProvider {
    static var previews: some View {
        LikeDislikeTracker()
    }
}
