//
//  AuthenticationView.swift
//  Wink
//
//  Created by Robert Pacheco on 7/12/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import SwiftUI


struct SignUpView : View {
    @State var email: String = ""
    @State var password: String = ""
    @State var loading = false
    @State var error = false
    
    @EnvironmentObject var session: SessionStore
    
    func signUp() {
        loading = true
        error = false
        session.signUp(email: email, password: password) { (result, error) in
            self.loading = false
            if error != nil {
                self.error = true
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
    
    var body: some View {
        VStack {
            
            Text("Create Account").color(.blue)
                .font(.title)
                .padding(.horizontal)
            
                
            CustomInput(text: $email, name: "Email Address")
                             .padding()
                
                VStack() {
                    SecureField($password, placeholder: Text("Password"))
                        .modifier(InputModifier())
                        .padding()
                    
                    Text("At least 8 characters required.").font(.footnote).color(Color.gray)
                }
            
            
            if (error) {
                InlineAlert(
                title: "Hmm.. That didn't work.",
                subtitle: "Are you sure you don't have an account with email address?"
                ).padding([.horizontal, .top])
            }
            
            CustomButton(
                label: "Sign Up",
                action: signUp
            )
            .disabled(loading)
            .padding()
                
            
            VStack {
                
                Divider()
                HStack(alignment: .center) {
                    Text("Have an account already?")
                        .font(.footnote)
                        .color(.purple)
                    
                    NavigationLink(destination: SignInView()) {
                        Text("Sign In.").font(.footnote)
                    }
                }
                
            }
            .padding()
            
        }
    }
}


struct SignInView : View {
    // Sign In With Apple
    @State var informationText = "Please Login!"
    @State var isUser = false
    
    private var suicaStack = VStack {
        Text("Welcome!")
            .font(.title)
            .padding(5.0)
    }

    @State var email: String = ""
    @State var password: String = ""
    @State var loading = false
    @State var error = false
    
    @EnvironmentObject var session: SessionStore
   
   
    
    func signIn() {
        loading = true
        error = false
        session.signIn(email: email, password: password) { (result, error) in
            self.loading = false
            if error != nil {
                self.error = true
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
    
    var body: some View {
        
        VStack {
            
            Group {
                
               Spacer()
                
                Text("Wink").font(.largeTitle).padding(.bottom)
                
                suicaStack
                Text(informationText)
                    .font(.footnote)
               
                
               
            }
            
            Spacer()
            
            Group {
                Spacer()
                
                CustomInput(text: $email, name: "Email Address")
                    .padding()
                
                SecureField("Password", text: $password)
                    .modifier(InputModifier())
                    .padding([.leading, .trailing])
                
                if (error) {
                    InlineAlert(
                        title: "Hmm... That didn't work.",
                        subtitle: "Please check your email and password again"
                    ).padding([.horizontal, .top])
                
                }
                
                CustomButton(
                    label: "Sign In",
                    action: signIn,
                    loading: loading
                )
                    .padding()
                
                }
            
            
            VStack {
                
                if !isUser {
                    SignInAppleButtonView(completion: {
                        self.isUser = true
                        self.informationText = "👮♀️ login success 👮♀️"
                    }).frame(width: 220, height: 50, alignment: .center)
                }
                
                
            }
            
            Spacer()
            Divider()
            VStack {
                
                Spacer()
                HStack(alignment: .center) {
                    Text("Don't have an account?")
                        .font(.footnote)
                        .color(.purple)
                    
                    NavigationLink(destination: SignUpView()) {
                        Text("Sign Up.").font(.footnote)
                    }
                }
                
            }
            .padding()
        }
        
    }
}
    
struct AuthenticationScreen : View {
    var body: some View {
        NavigationView {
            
            SignInView()
            
        }
        .padding(.all)
    }
}

#if DEBUG
struct AuthenticationView_Previews : PreviewProvider {
    static var previews: some View {
        AuthenticationScreen()
            .environmentObject(SessionStore())
    }
}
#endif
