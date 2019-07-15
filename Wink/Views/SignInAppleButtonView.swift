//
//  SignInAppleButtonViewswift.swift
//  Wink
//
//  Created by Robert Pacheco on 7/14/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import SwiftUI
import UIKit
import AuthenticationServices

struct SignInAppleButtonView: UIViewRepresentable {
    
    typealias UIViewType  = ASAuthorizationAppleIDButton
    
    let completion: () -> Void
    
    func makeCoordinator () -> Coordinator {
        Coordinator(self, completion: completion)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SignInAppleButtonView>) -> ASAuthorizationAppleIDButton {
        let signInButton = ASAuthorizationAppleIDButton(authorizationButtonType: .default, authorizationButtonStyle: DarkModeManager.isDarkMode ? .black : .white)
        
        signInButton.addTarget(context.coordinator,
                               action: #selector(Coordinator.signInWithApple),
                               for: .touchUpInside)
        
        return signInButton
        
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: UIViewRepresentableContext<SignInAppleButtonView>) {}
    
    class Coordinator: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
        
        let signInButton: SignInAppleButtonView
        let completion: () -> Void
        
        init(_ signInButton: SignInAppleButtonView, completion: @escaping () -> Void) {
            self.signInButton = signInButton
            self.completion = completion
        }
        
        @objc func signInWithApple() {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.email, .fullName]
            
            let appleIDAuthorizationController = ASAuthorizationController(authorizationRequests: [request])
            appleIDAuthorizationController.delegate = self
            appleIDAuthorizationController.presentationContextProvider = self
            appleIDAuthorizationController.performRequests()
            
        }
        
        func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
            guard let appleID = authorization.credential as? ASAuthorizationAppleIDCredential else {
                return
            }
            
            print("Login Succesful!")
            print(appleID.email)
            
            completion()
        }
        
        func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
            return UIWindow()
            
        }
        
    }
    
}

