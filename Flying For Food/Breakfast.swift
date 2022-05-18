//
//  Breakfast.swift
//  Flying For Food
//
//  Created by Rice on 8/28/21.
//

import SwiftUI
import FirebaseFirestore

struct Breakfast: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var rViewModel = reviewViewModel()
    @State var restaurantName = ""
    @State var selection = ""
    @State var recommendText = ""
    @State var checkedBreakfast = false
    @State var checkedLunch = false
    @State var checkedDinner = false
    @State var isEditActive = false
    //@FocusState var isInputActive: Bool
    let typeOfMeals = ["Breakfast", "Lunch", "Dinner"]
    var body: some View {
        ZStack{
            Image("Group 1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .center)
                .ignoresSafeArea()
            
            if let breakfast = aviationViewModel.textCorrespondingAvia?.Breakfast
            {
                //let arrayBreakfast = breakfast.components(separatedBy: "; ")
                let arrayBreakfast = sortRestaurants(rests: breakfast.components(separatedBy: "; "))
                VStack(spacing: 0){
                    ForEach(arrayBreakfast, id: \.self) { d in
                        if ((d.isEmpty) != true) {
                            let index = arrayBreakfast.firstIndex(of: d)
                            VStack(spacing: 0){
                                if (index == 0)
                                {
                                    VStack(spacing: 0){
                                        Spacer()
//                                        Text("DESTINATION")
//                                            .font(.title2)
//                                            .fontWeight(.bold)
                                        Text("Destination").font(.system(size: 20, weight: .bold)).foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5))).multilineTextAlignment(.center)
                                            .padding()
                                        Button(action: {
                                            var restCityState = d
                                            if let cityState = aviationViewModel.textCorrespondingAvia?.CityState {
                                                restCityState.append(" ")
                                                restCityState.append(cityState)
                                            }
                                            let replaceBF: String = restCityState.replacingOccurrences(of: " ", with: "+")
                                            let mapAddress: String = "maps://?q=\(replaceBF)"
                                            let components = transformURLString(mapAddress)
                                            if let url = components?.url{
                                                if UIApplication.shared.canOpenURL(url) {
                                                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                                }
                                            }
                                            UserDefaults.standard.set(d, forKey: "restaurant")
                                            UserDefaults.standard.set(aviationViewModel.textCorrespondingAvia?.IDENT, forKey: "Ident")
                                        }, label: {
                                            box(text: d, width: 260)
                                        })
                                            .padding(.bottom, 30)
                                        //Spacer()
                                    }
                                }
                                if (index == 1)
                                {
                                    VStack(spacing: 0){
//                                        Text("ALTERNATE")
//                                            .font(.title2)
//                                            .fontWeight(.semibold)
                                        //Destination
                                        Text("Alternate(s)").font(.system(size: 20, weight: .bold)).foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5))).multilineTextAlignment(.center)
                                            .padding()
                                        Button(action: {
                                            var restCityState = d
                                            if let cityState = aviationViewModel.textCorrespondingAvia?.CityState {
                                                restCityState.append(" ")
                                                restCityState.append(cityState)
                                            }
                                            let replaceBF: String = restCityState.replacingOccurrences(of: " ", with: "+")
                                            let mapAddress: String = "maps://?q=\(replaceBF)"
                                            let components = transformURLString(mapAddress)
                                            if let url = components?.url{
                                                if UIApplication.shared.canOpenURL(url) {
                                                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                                }
                                            }
                                            UserDefaults.standard.set(d, forKey: "restaurant")
                                            UserDefaults.standard.set(aviationViewModel.textCorrespondingAvia?.IDENT, forKey: "Ident")
                                        }, label: {
                                            box(text: d, width: 260)
                                        })
                                            .padding(.bottom)
                                    }
                                }
                                if (index == 2)
                                {
                                    VStack{
                                        Button(action: {
                                            var restCityState = d
                                            if let cityState = aviationViewModel.textCorrespondingAvia?.CityState {
                                                restCityState.append(" ")
                                                restCityState.append(cityState)
                                            }
                                            let replaceBF: String = restCityState.replacingOccurrences(of: " ", with: "+")
                                            let mapAddress: String = "maps://?q=\(replaceBF)"
                                            let components = transformURLString(mapAddress)
                                            if let url = components?.url{
                                                if UIApplication.shared.canOpenURL(url) {
                                                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                                }
                                            }
                                            UserDefaults.standard.set(d, forKey: "restaurant")
                                            UserDefaults.standard.set(aviationViewModel.textCorrespondingAvia?.IDENT, forKey: "Ident")
                                        }, label: {
                                            box(text: d, width: 260)
                                        })
                                    }
                                }
                            }
                        }
                    }
                    if arrayBreakfast[0] != ""
                    {   VStack{
                            Spacer()
                            Text("Have a suggestion? Make one here!").font(.custom("Roboto Regular", size: 14)).foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5))).multilineTextAlignment(.center)
                            NavigationLink(
                                destination: SuggestionPageForSpecificMeals(OneTypeMeal: "Breakfast"),
                                label: {
                                    suggetionButton()
                                })
//                        Button(action: {
//                            destination: Options()
//                        }, label: {
//                            box(text: "IDX", width: 100)
//                        })
                            Spacer()
                            NavigationLink(
                                destination: Options(),
                                label: {
                                    box(text: "IDX", width: 100)
                                })
                            .padding(.bottom, 30)
                        }
                    }
                    else{
                        suggestionPage
                    }
                }
            }
        }
        //.frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .center)
//        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                HStack{
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
                                }
        )
    }
    
    func sortRestaurants(rests: [String]) -> [String] {
        var sortedList: [RestaurantNetReview] = []
        let restaurants = rests
        if let iden = aviationViewModel.textCorrespondingAvia?.IDENT {
            for rest in restaurants {
                if rViewModel.isExisting(Ident: iden, restaurant: rest) {
                    if let thumbsUp = reviewViewModel.textCorrespondingReview?.thumbsUpCount {
                        if let thumbsDown = reviewViewModel.textCorrespondingReview?.thumbsDownCount {
                            let netThumbs = thumbsUp - thumbsDown
                            let restReview = RestaurantNetReview(restaurant: rest, IDENT: iden, netReviews: netThumbs)
                            sortedList.append(restReview)
                        }
                    }
                } else {
                    let reviewlessRest = RestaurantNetReview(restaurant: rest, IDENT: iden, netReviews: 0)
                    sortedList.append(reviewlessRest)
                }
            }
        }
        sortedList = sortedList.sorted(by: { rest1, rest2 in
            rest1.netReviews > rest2.netReviews
        })
        var sortedNames: [String] = []
//        for i in sortedList {
//            sortedNames.append(i.restaurant)
//        }
        if !(sortedList.isEmpty) {
            if sortedList.count == 1 {
                sortedNames.append(sortedList[0].restaurant)
            } else if sortedList.count == 2 {
                sortedNames.append(sortedList[0].restaurant)
                sortedNames.append(sortedList[1].restaurant)
            } else {
                sortedNames.append(sortedList[0].restaurant)
                sortedNames.append(sortedList[1].restaurant)
                sortedNames.append(sortedList[2].restaurant)
            }
        }
        return sortedNames
    }
}

struct Breakfast_Previews: PreviewProvider {
    static var previews: some View {
        Breakfast()
    }
}

extension Breakfast{
    
    private var suggestionPage: some View{
        VStack(spacing: 35){
            VStack(spacing: 10) {
                Text("There are no current reviews for breakfast for this airport. Please submit your recommendation here:")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .lineSpacing(5)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
                Text("Suggestion for: \(aviationViewModel.textCorrespondingAvia?.IDENT ?? "!")")
                    .font(.subheadline)
                    .foregroundColor(Color.black)
                    .fontWeight(.bold)
            }
            restaurantFiled
            textBox
            checkBox

            
            submitButton
        }
    }
    
    private var restaurantFiled: some View {

        VStack(spacing: 60){
            TextField("Restaurant Name", text: $restaurantName)
                .font(.system(size: 20))
                .disableAutocorrection(true)
                .multilineTextAlignment(.center)
                .padding(.leading, 10)
                .frame(width: 300, height: 40)
                .foregroundColor(.black)
                //.background(Color(white: 0.90))
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black)
                )
                .shadow(color: .gray, radius: 3, x: 0, y: 0)
                .onTapGesture {
                    isEditActive = false
                }
        }
    }
    
    private var checkBox: some View {

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
                    .shadow(color: .gray, radius: 3, x: 0, y: 0)
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
                    .shadow(color: .gray, radius: 3, x: 0, y: 0)
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
                    .shadow(color: .gray, radius: 3, x: 0, y: 0)
                Image(systemName: checkedDinner ? "checkmark.square.fill" : "squareshape")
                    .foregroundColor(checkedDinner ? Color(UIColor.systemBlue) : Color.secondary)
            }
            .onTapGesture {
                checkedDinner.toggle()
            }
        }
    }
    
    private var textBox: some View {

        VStack {
            HStack(alignment: .bottom){
                Text("Comment:")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.black).opacity(0.5)
                    .multilineTextAlignment(.center)
                Spacer()
                if isEditActive {
                    Button(action: {
                        UIApplication.shared.endEditing()
                        isEditActive = false
                    }, label: {
                        Rectangle()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.white, Color("skyblue")]), startPoint: .leading, endPoint: .trailing))
                            .frame(width: 150, height: 30)
                            .overlay(
                                Text("Close Keyboard")
                                    .font(.body)
                                    .foregroundColor(Color.black)
                                    .fontWeight(.bold)
                            )
                            .cornerRadius(10)
                            .shadow(color:.gray, radius: 3, x: 0, y: 0)
                    })
                }
            }
            .frame(width:300)
            //TextField("Additional Comments", text: $recommendText)
            TextEditor(text: $recommendText)
                .font(.title3).padding([.top, .leading, .trailing], 6.0)
                .frame(width: 300, height: 100, alignment: .topLeading)
                .foregroundColor(.black)
                .background(Color.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black)
                )
                .shadow(color: .gray, radius: 4, x: 0, y: 0)
                .onTapGesture {
                    isEditActive = true
                }
                //.focused($isInputActive)
//                .toolbar {
//                    ToolbarItemGroup(placement: .keyboard) {
//                        Spacer()
//                        Button("Done") {
//                            isInputActive = false
//                        }
//                    }
//                }
        }
    }
    
    private var submitButton: some View {
        Button(action: {
            save()
            checkedBreakfast = false
            checkedLunch = false
            checkedDinner = false
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color.white, Color("skyblue")]), startPoint: .leading, endPoint: .trailing))
                .frame(width: 100, height: 50)
                .overlay(
                    Text("Submit")
                        .font(.body)
                        .foregroundColor(Color.black)
                        .fontWeight(.bold)
                )
                .cornerRadius(15)
                .shadow(color:.black.opacity(0.25), radius: 2, x: 0, y: 0)
        })
    }
    
    func save(){
        let db = Firestore.firestore()
        var typeOfMeal: String = ""
        if checkedBreakfast
        {
            typeOfMeal += "Breakfast"
        }
        if checkedLunch
        {
            if typeOfMeal.isEmpty
            {
                typeOfMeal += "Lunch"
            }
            else{
                typeOfMeal += "&Lunch"
            }
        }
        if checkedDinner
        {
            if typeOfMeal.isEmpty
            {
                typeOfMeal += "Dinner"
            }
            else{
                typeOfMeal += "&Dinner"
            }
        }
        
        db.collection("suggestion").document().setData(["IDENT": aviationViewModel.textCorrespondingAvia?.IDENT ?? "", "restaurantName": restaurantName, "typeOfMeal": typeOfMeal, "comment": recommendText])
        restaurantName = ""
        recommendText = ""

    }
    
    func transformURLString(_ string: String) -> URLComponents? {
        guard let urlPath = string.components(separatedBy: "?").first else {
            return nil
        }
        var components = URLComponents(string: urlPath)
        if let queryString = string.components(separatedBy: "?").last {
            components?.queryItems = []
            let queryItems = queryString.components(separatedBy: "&")
            for queryItem in queryItems {
                guard let itemName = queryItem.components(separatedBy: "=").first,
                      let itemValue = queryItem.components(separatedBy: "=").last else {
                        continue
                }
                components?.queryItems?.append(URLQueryItem(name: itemName, value: itemValue))
            }
        }
        return components!
    }
}

struct suggetionButton: View{
    var body: some View{
        Rectangle()
            .fill(
                LinearGradient(gradient: Gradient(colors: [.white, Color(red: 135/255, green: 206/255, blue: 235/255, opacity: 1)]), startPoint: .leading, endPoint: .trailing)
            )
            .frame(width: 190, height: 75)
            .overlay(
                VStack{
                    Text("Suggestion")
                        .foregroundColor(Color.black)
                        .font(.title2)
                        .fontWeight(.semibold)
                }
            )
            .cornerRadius(10)
            .shadow(color: .gray, radius: 3, x: 0, y: 0)
    }
    
}
