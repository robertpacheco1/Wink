//
//  Session.swift
//  Wink
//
//  Created by Robert Pacheco on 7/12/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import SwiftUI
import Foundation
import Combine
import Firebase

struct User {
    var uid: String
    var email: String?
    var displayName: String?
    
    init(uid: String, displayName: String?, email: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
    }
}

class SessionStore : BindableObject {
    var willChange = PassthroughSubject<SessionStore, Never>()
    var session: User? { didSet { self.willChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?
    
    init(session: User? = nil) {
        self.session = session
    }
    
    func listen () {
        //monitor authentification changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // if we have user, create a new user model
                print("Got user: \(user)")
                self.session = User(
                    uid: user.uid,
                    displayName: user.displayName,
                    email: user.email
                )
            } else {
                // if we don't have user, seat our session to nil
                self.session = nil
            }
        }
    }
    
    // additional methods (sign up, sign in) will go here
    func signOut () -> Bool {
        do {
            try Auth.auth().signOut()
            self.session = nil
            return true
        } catch {
            return false
        }
    }
    // stop listening for auth changes
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    deinit {
        unbind()
    }
    
    func signUp(
        email : String,
        password: String,
        handler: @escaping AuthDataResultCallback)  {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    func signIn(
        email : String,
        password: String,
        handler: @escaping AuthDataResultCallback)  {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
}


