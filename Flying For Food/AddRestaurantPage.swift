//
//  AddRestaurantPage.swift
//  Flying For Food
//
//  Created by Kyle Davis on 2/16/22.
//

import SwiftUI

struct AddRestaurantPage: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var aviationCollection = aviationViewModel()
    @State var restaurantName: String = ""
    @State var airportIdent: String = ""
    @State var checkedBreakfast:Bool = false
    @State var checkedLunch:Bool = false
    @State var checkedDinner:Bool = false
    @State var success: Bool = false
    @State var showingOutput: Bool = false
    var body: some View {
        ZStack{
            Image("Group 1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .center)
                .ignoresSafeArea()
            
            VStack(spacing : 85){
                Spacer()
                VStack(spacing: 30){
                    //CreateAccountComponent(textCreateAccount: $restaurantName, text: "RESTAURANT NAME")
                    VStack(spacing: 10){
                        Text("Restaurant Name:").font(.system(size: 20, weight: .bold)).foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5))).multilineTextAlignment(.center)
                        TextField("", text: $restaurantName)
                            .font(.system(size: 20))
                            .disableAutocorrection(true)
                            .multilineTextAlignment(.center)
                            .padding(.leading, 10)
                            .frame(width: 300, height: 60)
                            .background(Color(white: 0.90))
                            .cornerRadius(10)
                            .shadow(color: .gray, radius: 3, x: 0, y: 0)
                    }
                    //CreateAccountComponent(textCreateAccount: $airportIdent, text: "AIRPORT IDENTIFIER")
                    VStack(spacing: 10){
                        Text("Airport Identifier").font(.system(size: 20, weight: .bold)).foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5))).multilineTextAlignment(.center)
                        TextField("", text: $airportIdent)
                            .autocapitalization(.allCharacters)
                            .textCase(.uppercase)
                            .font(.system(size: 20))
                            .disableAutocorrection(true)
                            .multilineTextAlignment(.center)
                            .padding(.leading, 10)
                            .frame(width: 300, height: 60)
                            .background(Color(white: 0.90))
                            .cornerRadius(10)
                            .shadow(color: .gray, radius: 3, x: 0, y: 0)
                    }
                    HStack(spacing: 13){
                        VStack(spacing: 7){
                            //frameMeal(text: "Breakfast", width: 100)
                            Rectangle()
                                .fill(LinearGradient(gradient: Gradient(colors: [.white, Color(red: 135/255, green: 206/255, blue: 235/255, opacity: 1)]), startPoint: .leading, endPoint: .trailing))
                                .frame(width: 100, height: 35)
                                .overlay(
                                    Text("Breakfast")
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .fontWeight(.bold)
                                )
                                .cornerRadius(10)
                                .shadow(color: .gray, radius: 2, x: 0, y: 0)
                            Image(systemName: checkedBreakfast ? "checkmark.square.fill" : "squareshape")
                                .foregroundColor(checkedBreakfast ? Color(UIColor.systemBlue) : Color.secondary)
                        }
                        
                        .onTapGesture {
                            checkedBreakfast.toggle()
                        }
                        VStack(spacing: 7){
                            //frameMeal(text: "Lunch", width: 100)
                            Rectangle()
                                .fill(LinearGradient(gradient: Gradient(colors: [.white, Color(red: 135/255, green: 206/255, blue: 235/255, opacity: 1)]), startPoint: .leading, endPoint: .trailing))
                                .frame(width: 100, height: 35)
                                .overlay(
                                    Text("Lunch")
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .fontWeight(.bold)
                                )
                                .cornerRadius(10)
                                .shadow(color: .gray, radius: 2, x: 0, y: 0)
                            Image(systemName: checkedLunch ? "checkmark.square.fill" : "squareshape")
                                .foregroundColor(checkedLunch ? Color(UIColor.systemBlue) : Color.secondary)
                        }
                        .onTapGesture {
                            checkedLunch.toggle()
                        }
                        VStack(spacing: 7){
                            //frameMeal(text: "Dinner", width: 100)
                            Rectangle()
                                .fill(LinearGradient(gradient: Gradient(colors: [.white, Color(red: 135/255, green: 206/255, blue: 235/255, opacity: 1)]), startPoint: .leading, endPoint: .trailing))
                                .frame(width: 100, height: 35)
                                .overlay(
                                    Text("Dinner")
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .fontWeight(.bold)
                                )
                                .cornerRadius(10)
                                .shadow(color: .gray, radius: 2, x: 0, y: 0)
                            Image(systemName: checkedDinner ? "checkmark.square.fill" : "squareshape")
                                .foregroundColor(checkedDinner ? Color(UIColor.systemBlue) : Color.secondary)
                        }
                        .onTapGesture {
                            checkedDinner.toggle()
                        }
                    }
                    if showingOutput {
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color.black)
                                .frame(width: 200, height: 60)
                            if success {
                                Text("Restaurant Added")
                                    .foregroundColor(Color.white)
                            }
                            else {
                                Text("Invalid")
                                    .foregroundColor(Color.white)
                            }
                        }
                    }
                }
                Button(action: {
                    if isFill() {
                        if aviationCollection.addRestaurant(restaurantName: restaurantName, airportIdent: airportIdent, isBreakfast: checkedBreakfast, isLunch: checkedLunch, isDinner: checkedDinner) {
                            success = true
                            showingOutput = true
                        } else {
                            success = false
                            showingOutput = true
                        }
                    }
                    //presentationMode.wrappedValue.dismiss()
                }, label: {
//                    Rectangle()
//                        .fill(Color.black)
//                        .opacity(0.75)
//                        .frame(width: 100, height: 40)
//                        .overlay(
//                            Text("Submit")
//                                .font(.title2)
//                                .foregroundColor(.white)
//                                .fontWeight(.bold)
//                        )
//                        .cornerRadius(7)
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [.white, Color(red: 135/255, green: 206/255, blue: 235/255, opacity: 1)]), startPoint: .leading, endPoint: .trailing))
                        .frame(width: 120, height: 45)
                        .overlay(
                            Text("SUBMIT")
                                .foregroundColor(Color.black)
                                .font(.title2)
                                .fontWeight(.semibold)
                        )
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 3, x: 0, y: 0)
                })
                //                if showingOutput {
                //                    ZStack {
                //                        Rectangle()
                //                            .foregroundColor(Color.black)
                //                            .frame(width: 200, height: 60)
                //                        if success {
                //                            Text("Admin User Added")
                //                                .foregroundColor(Color.white)
                //                        }
                //                        else {
                //                            Text("Account Does Not Exist")
                //                                .foregroundColor(Color.white)
                //                        }
                //                    }
                //                }
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
    
    func isFill() -> Bool{
        if restaurantName == ""{
            return false
        }
        if airportIdent == ""{
            return false
        }
        return true
    }
}

struct AddRestaurantPage_Previews: PreviewProvider {
    static var previews: some View {
        AddRestaurantPage()
    }
}
