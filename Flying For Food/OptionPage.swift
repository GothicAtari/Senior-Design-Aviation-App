//
//  OptionPage.swift
//  Flying For Food
//
//  Created by Rice on 8/17/21.
//

import SwiftUI

struct OptionPage: View {
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack{
            Image("plane")
                .resizable()
                .ignoresSafeArea()
            VStack(spacing: 40){
                box(text: "ABOUT US", width: 220)
                box(text: "SUGESTION", width: 220)
                box(text: "SUBSCRIBE", width: 220)
            }
            .offset(y: -200)
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
        )}
    }
}

struct OptionPage_Previews: PreviewProvider {
    static var previews: some View {
        BlurbPage()
    }
}
