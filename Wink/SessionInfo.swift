//
//  SessionInfo.swift
//  Wink
//
//  Created by Robert Pacheco on 7/13/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct SessionInfo : View {
    
    @EnvironmentObject var session: SessionStore
    @Environment(\.isPresented) var isPresented: Binding<Bool>?
    
    var body: some View {
        Button("Log Out") {
            self.session.signOut()
            self.isPresented?.value = false
        }
    }
}

#if DEBUG
struct SessionInfo_Previews : PreviewProvider {
    static var previews: some View {
        SessionInfo().environmentObject(SessionStore())
    }
}
#endif
