//
//  ReviewPage.swift
//  Flying For Food
//
//  Created by Rice on 10/18/21.
//

import SwiftUI
import FirebaseFirestore

struct ReviewPage: View {
    @State var restaurant: String = UserDefaults.standard.string(forKey: "restaurant") ?? ""
    @State private var isShowFrontPage = false
    @StateObject var reviewModel = reviewViewModel()
    var body: some View {
        ZStack{
            Image("Group 1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .center)
                .ignoresSafeArea()
            VStack(spacing: 35){
                VStack(spacing: 25){
                    Text("Thanks for visiting " + restaurant + "!")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.black).opacity(0.5)
                        .multilineTextAlignment(.center)
                    Text("What did you think?")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.black).opacity(0.5)
                        .multilineTextAlignment(.center)
                }
                VStack(spacing: 50){
                    HStack{
                        NavigationLink(destination: FrontPage(), isActive: $isShowFrontPage)
                        {
                            EmptyView()
                        }
                        Spacer()
                        Button(action: {
                        reviewModel.thumbsDownAdd(Ident: UserDefaults.standard.string(forKey: "Ident") ?? "", restaurant: UserDefaults.standard.string(forKey: "restaurant") ?? "")
                        UserDefaults.standard.set("", forKey: "restaurant")
                        isShowFrontPage = true
                        }, label: {
                            Image("Group 2")
                                .resizable()
                                .frame(width: 100, height: 100)
                        })
                        Spacer()
                        NavigationLink(destination: FrontPage(), isActive: $isShowFrontPage)
                        {
                            EmptyView()
                        }
                        Button(action: {
                            reviewModel.thumbsUpAdd(Ident: UserDefaults.standard.string(forKey: "Ident") ?? "", restaurant: UserDefaults.standard.string(forKey: "restaurant") ?? "")
                            UserDefaults.standard.set("", forKey: "restaurant")
                            isShowFrontPage = true
                        }, label: {
                            Image("Group 3")
                                .resizable()
                                .frame(width: 100, height: 100)
                        })
                        Spacer()
                    }
                    VStack(spacing: 50){
                        NavigationLink(destination: FrontPage(), isActive: $isShowFrontPage)
                        {
                            EmptyView()
                        }
                        Button(action: {
                            UserDefaults.standard.set("", forKey: "restaurant")
                            isShowFrontPage = true
                        }, label: {
                            doNotVisitFrame
                        })
                        NavigationLink(
                            destination: Options(),
                            label:{ option }
                        )
                    }
                }
            }.offset(y: 80)
        }
    }
        
    private var doNotVisitFrame: some View{
        Rectangle()
            .fill(LinearGradient(gradient: Gradient(colors: [Color.white, Color("skyblue")]), startPoint: .leading, endPoint: .trailing))
            .frame(width: 150, height: 60)
            .overlay(
            Text("Did not visit")
                    .font(.title3)
                    .foregroundColor(Color.black)
            )
            .cornerRadius(15)
            .shadow(color:.black.opacity(0.25), radius: 2, x: 2, y: 10)
    }
    
    private var option: some View{
        Rectangle()
            .fill(LinearGradient(gradient: Gradient(colors: [Color.white, Color("skyblue")]), startPoint: .leading, endPoint: .trailing))
            .frame(width: 80, height: 40)
            .overlay(
            Text("IDX")
                .font(.title2)
                .foregroundColor(.black)
                .fontWeight(.bold)
            )
            .cornerRadius(15)
            .shadow(color:.black.opacity(0.25), radius: 2, x: 2, y: 10)
    }}

struct ReviewPage_Previews: PreviewProvider {
    static var previews: some View {
        ReviewPage()
    }
}
