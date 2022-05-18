//
//  FrontPage.swift
//  Flying For Food
//
//  Created by Rice on 8/17/21.
//

import SwiftUI

struct FrontPage: View {
    @StateObject var viewModel = aviationViewModel()
    @State var textIdent = ""
    @State var isAnimation: Bool = false
    var body: some View {
        ZStack{
            Image("Group 1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .center)
                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Type in an airport identifier:").font(.system(size: 20, weight: .bold)).foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5))).multilineTextAlignment(.center)
                VStack(spacing: 33) {
                    TextField("Ex. IAD", text: $textIdent)
                        .autocapitalization(.allCharacters)
                        .textCase(.uppercase)
                        .font(.system(size: 20))
                        .disableAutocorrection(true)
                        .multilineTextAlignment(.center)
                        .padding(.leading, 10)
                        .frame(width: 300, height: 60)
                        .background(Color(white: 0.90))
                        .onTapGesture {
                            isAnimation = true
                        }
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 3, x: 0, y: 0)
                        
                    
                    if (viewModel.isSpecificData(ident: textIdent)) {
                        NavigationLink(
                            destination: Meals(),
                            label:{ labelExec }
                        )
                    }
                    else{
                        Button(action: {}, label: {
                            labelExec
                        })
                        .disabled(!viewModel.isSpecificData(ident: textIdent))
                    }
                }
                Spacer()
                NavigationLink(
                    destination: Options(),
                    label: {
                        box(text: "IDX", width: 100)
                    })
                .padding(.bottom, 30)
            }
            .animation(isAnimation ? .easeInOut(duration: 1.0) : nil)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(trailing:
                                    NavigationLink(
                                        destination: HelpPage(),
                                        label: {
                                            Rectangle()
                                                .fill(
                                                    LinearGradient(gradient: Gradient(colors: [.white, Color(red: 135/255, green: 206/255, blue: 235/255, opacity: 1)]), startPoint: .leading, endPoint: .trailing)
                                                )
                                                //.frame(width: width, height: 45)
                                                .frame(minWidth: 60, maxWidth: 60, minHeight: 40, idealHeight: 40, maxHeight: 40)
                                                .overlay(
                                                    Text("Help")
                                                        .font(.title2)
                                                    .foregroundColor(.black)
                                                    .fontWeight(.bold)
                                                )
                                                .cornerRadius(10)
                                                .shadow(color: .gray, radius: 3, x: 0, y: 0)
                                        })
                                    )
        }
        //.frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .center)
        .navigationViewStyle(StackNavigationViewStyle())
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    private var labelExec: some View{
        Rectangle()
            .fill(viewModel.isSpecificData(ident: textIdent) ? LinearGradient(gradient: Gradient(colors: [.white, Color(red: 135/255, green: 206/255, blue: 235/255, opacity: 1)]), startPoint: .leading, endPoint: .trailing) : LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.4), .gray.opacity(0.4)]), startPoint: .leading, endPoint: .trailing))
            .frame(width: 150, height: 55)
            .overlay(
                Text("EXEC")
                    .foregroundColor(viewModel.isSpecificData(ident: textIdent) ? Color.black : Color(red: 200/255, green: 200/255, blue: 200/255, opacity: 1))
                    .font(.title2)
                    .fontWeight(.semibold)
            )
            .cornerRadius(10)
            .shadow(color: .gray, radius: 3, x: 0, y: 0)
    }
    
    private var option: some View{
        Rectangle()
            .fill(Color.black)
            .frame(width: 150, height: 55)
            .overlay(
                Text("IDX")
                    .foregroundColor(Color.white)
                    .font(.title2)
                    .fontWeight(.semibold)
            )
            .cornerRadius(12)
    }
}

struct FrontPage_Previews: PreviewProvider {
    static var previews: some View {
        FrontPage()
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
