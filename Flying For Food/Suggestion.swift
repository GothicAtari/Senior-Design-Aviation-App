//
//  Suggestion.swift
//  Flying For Food
//
//  Created by Rice on 10/17/21.
//

import SwiftUI
import FirebaseFirestore

struct Suggestion: View {
    @State var identName = ""
    @State var restaurantName = ""
    @State var selection = ""
    @State var recommendText = ""
    @State var breakfast = false
    @State var lunch = false
    @State var dinner = false
    @State var expand = false
    @State var dropDownText = "Meal Type"
    @State var isEditActive = false
    //@FocusState var isInputActive: Bool
    //    @State private var bottomPadding: CGFloat = 0
    @Environment(\.presentationMode) var presentationMode
    let typeOfMeals = ["Breakfast", "Lunch", "Dinner"]
    var body: some View {
        ZStack{
            Image("Group 1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .center)
                .ignoresSafeArea()
            //dropDown.zIndex(1).offset(y: 8)
            wholeBody
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
    
    private var wholeBody: some View{
        VStack(spacing: 30){
            VStack(spacing: 10){
                VStack(spacing: 14){
                    Text("Please submit your restaurant recommendations here:")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.black).opacity(0.5)
                        .multilineTextAlignment(.center)
                    }
                airportID
                restaurantField
            }
            textBox
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
                    Image(systemName: breakfast ? "checkmark.square.fill" : "squareshape")
                        .foregroundColor(breakfast ? Color(UIColor.systemBlue) : Color.secondary)
                }
                
                .onTapGesture {
                    breakfast.toggle()
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
                    Image(systemName: lunch ? "checkmark.square.fill" : "squareshape")
                        .foregroundColor(lunch ? Color(UIColor.systemBlue) : Color.secondary)
                }
                .onTapGesture {
                    lunch.toggle()
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
                    Image(systemName: dinner ? "checkmark.square.fill" : "squareshape")
                        .foregroundColor(dinner ? Color(UIColor.systemBlue) : Color.secondary)
                }
                .onTapGesture {
                    dinner.toggle()
                }
            }
            //textBox
            submitButton
        }
        .offset(y: 20)
    }
    
    private var restaurantField: some View{
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
    
    private var dropDown: some View{
                VStack(spacing: 15){
                    HStack(spacing: 170){
                        Text(dropDownText)
                            .font(.title3)
                            .padding(.horizontal, 6)
                            .opacity(0.4)
                        Image(systemName: expand ? "chevron.up" : "chevron.down")
                            .resizable()
                            .frame(width: 13, height: 6)
                            .padding(.horizontal, 6)
                    }.onTapGesture{
                        self.expand.toggle()
                    }
                    if expand{
                        Button(action: {
                            self.expand.toggle()
                            dropDownText = "Breakfast"
                            breakfast = true;
                        }) {
                            Text("Breakfast")
                        }.foregroundColor(.black)
                        Button(action: {
                            self.expand.toggle()
                            dropDownText = "Lunch"
                            lunch = true;
                        }) {
                            Text("Lunch")
                        }.foregroundColor(.black)
                        Button(action: {
                            self.expand.toggle()
                            dropDownText = "Dinner"
                            dinner = true;
                        }) {
                            Text("Dinner")
                        }.foregroundColor(.black)
                        
                    }
                }
                .frame(minWidth: 300,
                       minHeight: 40)
                .foregroundColor(.black)
                .background(Color.white)
                .cornerRadius(8)
                //.animation(.spring())
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black)
                )
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
    
    private var airportID: some View{
        VStack(spacing: 60){
            TextField("Airport identifier", text: $identName)
                .autocapitalization(.allCharacters)
                .textCase(.uppercase)
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
    private var submitButton: some View{
        Button(action: {
            save()
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
        if breakfast
        {
            typeOfMeal += "Breakfast"
        }
        if lunch
        {
            if typeOfMeal.isEmpty
            {
                typeOfMeal += "Lunch"
            }
            else{
                typeOfMeal += "&Lunch"
            }
        }
        if dinner
        {
            if typeOfMeal.isEmpty
            {
                typeOfMeal += "Dinner"
            }
            else{
                typeOfMeal += "&Dinner"
            }
        }
        if identName.count == 4 && identName[identName.startIndex] == "K" {
            identName.remove(at: identName.startIndex)
        }
        let name: String = UserDefaults.standard.string(forKey: "name") ?? ""
        db.collection("suggestion").document().setData(["IDENT": identName, "restaurantName": restaurantName, "typeOfMeal": typeOfMeal, "comment": recommendText, "Name": name])
        identName = ""
        restaurantName = ""
        recommendText = ""
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct Suggestion_Previews: PreviewProvider {
    static var previews: some View {
        Suggestion()
    }
}


