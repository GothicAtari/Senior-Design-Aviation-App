//
//  WelcomePage.swift
//  Flying For Food
//
//  Created by Rice on 10/18/21.
//

import SwiftUI

struct WelcomePage: View {
    var body: some View {
        ZStack{
            Image("Group 1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .center)
                .ignoresSafeArea()
            VStack(spacing: 40){
                VStack(spacing: 0){
                    Text("Welcome to")
                        .fontWeight(.bold)
                    Text("Flying for Food")
                        .fontWeight(.bold)
                }
                .font(.largeTitle)
                Image("Logo")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 300, height: 300)
                    .clipShape(Circle())
                rectangularStyle(
                    text: "WATCH TUTORIAL")
                NavigationLink(
                    destination: FrontPage(),
                    label: {
                        rectangularStyle(
                            text: "SKIP")
                    })
            }
        }
        .navigationBarHidden(true)
    }
}

struct WelcomePage_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePage()
    }
}
