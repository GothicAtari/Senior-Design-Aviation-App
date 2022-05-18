//
//  HelpPage.swift
//  Flying For Food
//
//  Created by Kyle Davis on 4/19/22.
//

import SwiftUI

struct HelpPage: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack{
            Image("Group 1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .center)
                .ignoresSafeArea()
            
            VStack(spacing: 15){
                Spacer()
                VStack {
                    Text("Flying For Food").font(.system(size: 30, weight: .bold)).foregroundColor(Color.black).multilineTextAlignment(.center)
                    Text("Help").font(.system(size: 30, weight: .bold)).foregroundColor(Color.black).multilineTextAlignment(.center)
                }
                Text("Flying For Food helps pilots find quick places to eat in unfamiliar places.").font(.system(size: 20, weight: .bold)).foregroundColor(Color.black).multilineTextAlignment(.center)
                    .frame(maxWidth: UIScreen.main.bounds.width - 30, maxHeight: nil, alignment: .center)
                Text("Here's how it works:").font(.system(size: 20, weight: .bold)).foregroundColor(Color.black).multilineTextAlignment(.center)
                VStack(alignment: .leading, spacing: 10){
                    Text("1. Enter the airport idenifier.")
                        .bold()
                    Text("2. Select meal type.")
                        .bold()
                    Text("3. Choose your _**DESTINATION**_ or _**ALTERNATE**_")
                        .bold()
                    Text("4. Don't forget to rate the restaurant next time you open the app!")
                        .bold()
                }
                .frame(maxWidth: UIScreen.main.bounds.width - 30, maxHeight: nil, alignment: .center)
                Text("Blue skies and Happy Eating!").font(.system(size: 20, weight: .bold)).foregroundColor(Color.black).multilineTextAlignment(.center)
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

struct HelpPage_Previews: PreviewProvider {
    static var previews: some View {
        HelpPage()
    }
}
