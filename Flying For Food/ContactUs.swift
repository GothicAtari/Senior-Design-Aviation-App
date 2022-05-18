//
//  ContactUs.swift
//  Flying For Food
//
//  Created by Brendan South on 2/7/22.
//

import SwiftUI

struct ContactUsPage: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack{
            Image("Group 1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .center)
                .ignoresSafeArea()
            VStack{
                Text("Submit a PIREP!")
                    .fontWeight(.semibold)
                    .padding()
                Text("Email us at:")
                    .fontWeight(.semibold)
                Text("flyingforfoodapp@gmail.com")
                    .fontWeight(.semibold)
                    .underline()
                    .padding(.bottom, 10)
                Text("Follow us on Instagram:")
                    .fontWeight(.semibold)
                Button(action: {
                    guard let url = URL(string: "https://instagram.com/flyingforfoodapp")  else { return }
                    if UIApplication.shared.canOpenURL(url) {
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(url)
                        }
                    }
                }, label: {
                    Text("@flyingforfoodapp")
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                        .underline()
                })
                    .background(Color.clear)
                
                Spacer()
                
            }
            .font(.title2)
            .multilineTextAlignment(.center)
            .navigationBarBackButtonHidden(true)
            .offset(y: 125)
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
    
    func openInstagram(instagramHandle: String) {
        guard let url = URL(string: "https://instagram.com/\(instagramHandle)")  else { return }
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}

struct ContactUs_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsPage()
    }
}
