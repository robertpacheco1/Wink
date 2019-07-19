//
//  AppView.swift
//  Wink
//
//  Created by Robert Pacheco on 7/12/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct AppView: View {
    

    
    @EnvironmentObject var session: SessionStore
    
    
    var body: some View {
        return NavigationView {
            VStack(alignment: .leading) {
                Spacer()
                SpinnerView()
                Spacer()
                FacebookReactions()
                .offset(x: -130)

                Spacer()
            
            }.navigationBarTitle(Text("Wink"), displayMode: .inline)
                .navigationBarItems(leading: PresentationLink(destination: SessionInfo().environmentObject(session)) {
                    Image(systemName: "person.crop.circle")
                        .imageScale(.large)
                        .accessibility(label: Text("User Profile"))
                    },
                                    trailing: HStack(spacing: 24) {
                                        Button(action: { print("Search") }) {
                                            Image(systemName: "magnifyingglass")
                                                .imageScale(.large)
                                                .accessibility(label: Text("Search"))
                                        }
                    }
            )
        }
    }
}

#if DEBUG
struct AppView_Previews : PreviewProvider {
    static var previews: some View {
        AppView()
            .environmentObject(SessionStore())
    }
}
#endif
