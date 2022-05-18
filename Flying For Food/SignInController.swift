//
//  SignInController.swift
//  Flying For Food
//
//  Created by Rice on 10/18/21.
//

import SwiftUI

struct SignInController: View {
    var body: some View {
        NavigationView {
            if UserDefaults.standard.integer(forKey: "isSignPage") == 0 {
                SignIn()
                    .onAppear(){
                        UserDefaults.standard.set("", forKey: "restaurant")
                    }
            }
            else{
                if (UserDefaults.standard.string(forKey: "restaurant") == "")
                {
                    FrontPage()
                }
                else{
                    ReviewPage()
                }
            }
        }
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

struct SignInController_Previews: PreviewProvider {
    static var previews: some View {
        SignInController()
    }
}
