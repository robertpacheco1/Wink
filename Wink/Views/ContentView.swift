//
//  ContentView.swift
//  Wink
//
//  Created by Robert Pacheco on 7/11/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import Combine
import SwiftUI

struct ContentView: View {
   
    @EnvironmentObject var session: SessionStore
    
    func getUser() {
        session.listen()
    }
    
 
    var body: some View {
        NavigationView {
            
            VStack {
                if (session.session != nil) {
                    AppView()
                } else {
                    SignInView()
                }
            }
            
            
            
        }.onAppear(perform: getUser)
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SessionStore())
    }
}
#endif
