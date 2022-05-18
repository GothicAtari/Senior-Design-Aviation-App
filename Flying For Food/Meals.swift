//
//  Meals.swift
//  Flying For Food
//
//  Created by Rice on 8/17/21.
//

import SwiftUI

struct Meals: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack{
            Image("Group 1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .center)
                .ignoresSafeArea()
            
            VStack(spacing: 40){
                Spacer()
                Text("Choose a meal type:").font(.system(size: 20, weight: .bold)).foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5))).multilineTextAlignment(.center)
                NavigationLink(
                    destination: Breakfast(),
                    label: {
                        box(text: "BREAKFAST", width: 220)
                    })
                NavigationLink(
                    destination: Lunch(),
                    label: {
                        box(text: "LUNCH", width: 220)
                    })
                NavigationLink(
                    destination: Dinner(),
                    label: {
                        box(text: "DINNER", width: 220)
                    })
                Spacer()
                NavigationLink(
                    destination: Options(),
                    label: {
                        box(text: "IDX", width: 100)
                    })
                    .padding(.bottom, 30)
                
            }
        }
        //.frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .center)
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
                                }              
        )
    }
}

struct box: View
{
    let text: String
    let width: CGFloat
    var body: some View{
    Rectangle()
        .fill(
            LinearGradient(gradient: Gradient(colors: [.white, Color(red: 135/255, green: 206/255, blue: 235/255, opacity: 1)]), startPoint: .leading, endPoint: .trailing)
        )
        //.frame(width: width, height: 45)
        .frame(minWidth: width, maxWidth: width + 10, minHeight: 45, idealHeight: 45, maxHeight: 45)
        .overlay(
            Text(text)
                .font(.title2)
            .foregroundColor(.black)
            .fontWeight(.bold)
        )
        .cornerRadius(10)
        .shadow(color: .gray, radius: 3, x: 0, y: 0)
        
    }
}

struct frameMeal: View
{
    let text: String
    let width: CGFloat
    var body: some View{
    Rectangle()
        .fill(Color.black)
        .frame(width: width, height: 35)
        .overlay(
            Text(text)
                .font(.body)
            .foregroundColor(.white)
            .fontWeight(.bold)
        )
        .cornerRadius(10)
    }
}

struct Meals_Previews: PreviewProvider {
    static var previews: some View {
        BlurbPage()
    }
}
