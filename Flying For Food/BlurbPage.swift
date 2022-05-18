//
//  BlurbPage.swift
//  Flying For Food
//
//  Created by Rice on 10/18/21.
//

import SwiftUI

struct BlurbPage: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack{
            Image("Group 1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .center)
                .ignoresSafeArea()
            VStack(spacing: 20){
                HStack {
                    Image("MichaelPic")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(7)
                        .overlay(RoundedRectangle(cornerRadius: 7)
                            .stroke(Color.black, lineWidth: 1))
                    Image("WillPic")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(7)
                        .overlay(RoundedRectangle(cornerRadius: 7)
                            .stroke(Color.black, lineWidth: 1))
                
                }
                    .shadow(radius: 10)
                VStack(spacing: 0){
                    Text("Thanks for joining Flying for Food!")
                        .fontWeight(.semibold)
                    Text("The unique app designed by aviators, for aviators.")
                        .fontWeight(.semibold)
                }
                
                VStack(alignment: .center, spacing: 2){

//                    Text("Flying for Food was created with one goal in mind: to help pilots and air crews quickly and conveniently find good eateries near airports. Follow the steps below to get started:")
//                    Text("Between the two of us, we have thousands of  hours flying around the U.S. as corporate pilots. While we love our jobs, we also love the adventures associated with general aviation flying – especially trying new restaurants!")
//                    Text("There are over 5000 public use airports in the U.S. Although we have visited many of them, there still countless more airports we have not flown in to. Therefore, we need your help to grow our database of restaurants.")
//                    Text("This app uses your recommendations to aid fellow aircrews in discovering those sometimes unknown or local gems.")
//                    Text("Again, these suggestions have been submitted by YOUR fellow aviators, so you know it’s good! Email us with your questions, comments or concerns.")
                    Text("Flying for Food was created with one goal in mind: to help pilots and air crews quickly and conveniently find good eateries near airports. Between the two of us, we have thousands of  hours flying around the U.S. as corporate pilots. While we love our jobs, we also love the adventures associated with general aviation flying – especially trying new restaurants! There are over 5000 public use airports in the U.S. Although we have visited many of them, there still countless more airports we have not flown in to. Therefore, we need your help to grow our database of restaurants. This app uses your recommendations to aid fellow aircrews in discovering those sometimes unknown or local gems. Again, these suggestions have been submitted by YOUR fellow aviators, so you know it’s good! Email us with your questions, comments or concerns.")
                        .fixedSize(horizontal: false, vertical: true)
                    Text("Blue skies and happy eating!")
                }
                //.frame(maxWidth: UIScreen.main.bounds.width - 30, maxHeight: nil, alignment: .center)
                .padding(.horizontal, 4)
                
                
                
                VStack(spacing: 30) {
                    
                    Text("- Michael & Will")
                        .offset(x: -20)
                }
            }
            .padding(.horizontal, 6)
            .multilineTextAlignment(.center)
            .navigationBarBackButtonHidden(true)
            //.offset(y: 75)
            //.offset(y: 20)
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
    }
}

struct BlurbPage_Previews: PreviewProvider {
    static var previews: some View {
        BlurbPage()
    }
}
