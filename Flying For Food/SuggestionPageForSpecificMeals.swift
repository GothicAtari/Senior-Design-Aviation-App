//
//  Suggestion.swift
//  Flying For Food
//
//  Created by Rice on 10/17/21.
//

import SwiftUI
import FirebaseFirestore

struct SuggestionPageForSpecificMeals: View {
    @State var restaurantName = ""
    @State var selection = ""
    @State var recommendText = ""
    @State var checkedBreakfast = false
    @State var checkedLunch = false
    @State var checkedDinner = false
    @State var isEditActive = false
    //@FocusState var isInputActive: Bool
    let OneTypeMeal: String
    @Environment(\.presentationMode) var presentationMode
    let typeOfMeals = ["Breakfast", "Lunch", "Dinner"]
    var body: some View {
        ZStack{
            Image("Group 1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .center)
                .ignoresSafeArea()
            VStack(spacing: 35){
//                VStack(spacing: 1){
//                    Text("There are no current reviews for this airport. Please submit your recommendation here")
//                        .font(.subheadline)
//                        .fontWeight(.bold)
//                        .foregroundColor(Color(#colorLiteral(red: 0.6676766872, green: 0.03418145329, blue: 0.2740552723, alpha: 1)))
//                        .lineSpacing(5)
//                        .padding(.horizontal)
//                        .multilineTextAlignment(.center)
                     
//                    Text("Please submit your recommendation here")
//                        .font(.subheadline)
//                        .fontWeight(.bold)
//                        .foregroundColor(Color(#colorLiteral(red: 0.6676766872, green: 0.03418145329, blue: 0.2740552723, alpha: 1)))
//                        .lineSpacing(5)
//                        .padding(.horizontal)
//                }
                Text("Suggestion for: \(aviationViewModel.textCorrespondingAvia?.IDENT ?? "!")")
                    .font(.subheadline)
                    .foregroundColor(Color.black)
                    .fontWeight(.bold)
                restaurantFiled
                textBox
                checkBox
                
//                Text("Please type your comment below:")
//                    .font(.subheadline)
//                    .foregroundColor(Color.black)
                
                submitButton
            }
        }
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
    
    private var restaurantFiled: some View{
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
    
    private var checkBox: some View{
//        HStack(spacing: 13){
//            VStack(spacing: 7){
//                frameMeal(text: "Breakfast", width: 100)
//                Image(systemName: checkedBreakfast ? "checkmark.square.fill" : "squareshape")
//                    .foregroundColor(checkedBreakfast ? Color(UIColor.systemRed) : Color.secondary)
//            }
//            .onTapGesture {
//                checkedBreakfast.toggle()
//            }
//            VStack(spacing: 7){
//                frameMeal(text: "Lunch", width: 100)
//                Image(systemName: checkedLunch ? "checkmark.square.fill" : "squareshape")
//                    .foregroundColor(checkedLunch ? Color(UIColor.systemRed) : Color.secondary)
//            }
//            .onTapGesture {
//                checkedLunch.toggle()
//            }
//            VStack(spacing: 7){
//                frameMeal(text: "Dinner", width: 100)
//                Image(systemName: checkedDinner ? "checkmark.square.fill" : "squareshape")
//                    .foregroundColor(checkedDinner ? Color(UIColor.systemRed) : Color.secondary)
//            }
//            .onTapGesture {
//                checkedDinner.toggle()
//            }
//        }
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
    
    private var textBox: some View{

        
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
//                .focused($isInputActive)
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
    
    private var submitButton: some View{
//        Button(action: {
//            save()
//            checkedBreakfast = false
//            checkedLunch = false
//            checkedDinner = false
//            presentationMode.wrappedValue.dismiss()
//        }, label: {
//            Rectangle()
//                .fill(Color.black)
//                .opacity(0.75)
//                .frame(width: 100, height: 40)
//                .overlay(
//                    Text("Submit")
//                    .font(.title2)
//                    .foregroundColor(.white)
//                    .fontWeight(.bold)
//                )
//                .cornerRadius(7)
//        })
        
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
        
        db.collection("suggestion").document().setData(["IDENT": aviationViewModel.textCorrespondingAvia?.IDENT ?? "!", "restaurantName": restaurantName, "typeOfMeal": typeOfMeal, "comment": recommendText])
        restaurantName = ""
        recommendText = ""
    }
}

struct SuggestionPageForSpecificMeals_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionPageForSpecificMeals(OneTypeMeal: "ss")
    }
}
