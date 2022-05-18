//
//  AppInfoPage.swift
//  Flying For Food
//
//  Created by Kyle Davis on 4/1/22.
//

import SwiftUI

struct AppInfoPage: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var accountModel = accountViewModel()
    @StateObject var aviationModel = aviationViewModel()
    var body: some View {
        ZStack{
            Image("Group 1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .center)
                .ignoresSafeArea()
            
            VStack(spacing : 20){
                Spacer()
                Text("Accounts Created: \(accountModel.acccountCount())").font(.system(size: 20, weight: .bold)).foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5))).multilineTextAlignment(.center)
                Divider()
                Text("Airports: \(aviationModel.airportCount())").font(.system(size: 20, weight: .bold)).foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5))).multilineTextAlignment(.center)
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
}

struct AppInfoPage_Previews: PreviewProvider {
    static var previews: some View {
        AppInfoPage()
    }
}
