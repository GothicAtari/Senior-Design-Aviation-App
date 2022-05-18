//
//  TrackerRestaurantIndivView.swift
//  Flying For Food
//
//  Created by Kyle Davis on 4/12/22.
//

import SwiftUI

struct TrackerRestaurantIndivView: View {
    var review: review
    var mealType: String
    @State var isEditActive: Bool = false
    @State var thumbsUp: Int = 0
    @State var thumbsDown: Int = 0
    @StateObject var reviewModel = reviewViewModel()
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
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
                    Text(review.restaurant)
                        .font(.system(size: 20))
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
                    Text(mealType)
                        .font(.system(size: 20))
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
                    Text(review.IDENT)
                        .font(.system(size: 20))
                        .padding(.horizontal)
                        .padding(.top, 1)
                    Divider()
                }
                .padding(2)
                .padding(.horizontal)
                
                HStack {
                    Spacer()
                    HStack {
                        Image("Thumbs up")
                            .scaledToFit()
                        if isEditActive {
                            TextField("", value: $thumbsUp, formatter: formatter)
                                .keyboardType(.decimalPad)
                                .foregroundColor(Color.black)
                                .font(.system(size: 16))
                                .padding(.leading, 2)
                                .frame(width: 30, height: 30)
                                .background(Color(.white))
                                .cornerRadius(2)
                                .shadow(color: .gray, radius: 3, x: 0, y: 0)
                        }
                        else {
                            Text("\(review.thumbsUpCount)")
                            .font(.system(size: 18))
                        }
                    }
                    Spacer()
                    HStack {
                        Image("Thumbs down")
                            .scaledToFit()
                        if isEditActive {
                            TextField("", value: $thumbsDown, formatter: formatter)
                                .keyboardType(.decimalPad)
                                .foregroundColor(Color.black)
                                .font(.system(size: 16))
                                .padding(.leading, 2)
                                .frame(width: 30, height: 30)
                                .background(Color(.white))
                                .cornerRadius(2)
                                .shadow(color: .gray, radius: 3, x: 0, y: 0)
                        }
                        else {
                            Text("\(review.thumbsDownCount)")
                            .font(.system(size: 18))
                        }
                    }
                    Spacer()
                }
                if !isEditActive {
                    Button(action: {
                        isEditActive = true
                        thumbsUp = review.thumbsUpCount
                        thumbsDown = review.thumbsDownCount
                    }, label: {
                        box(text: "Edit", width: 100)
                    })
                } else {
                    HStack {
                    Button(action: {
                        save()
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        box(text: "Save", width: 100)
                    })
                            .padding()
                    Button(action: {
                        isEditActive = false
                    }, label: {
                        box(text: "Cancel", width: 100)
                    })
                            .padding()
                    }
                }
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
            Spacer()
            
        }
                                .onTapGesture {
            presentationMode.wrappedValue.dismiss()
        })
    }
    
    func save() {
        isEditActive = false
        reviewModel.thumbsEdit(newUpValue: thumbsUp, newDownValue: thumbsDown, name: review.restaurant, identifer: review.IDENT)
    }
}

//struct TrackerRestaurantIndivView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrackerRestaurantIndivView()
//    }
//}
