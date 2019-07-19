//
//  CustomButton.swift
//  Wink
//
//  Created by Robert Pacheco on 7/12/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct CustomButton : View {
    var label: String
    var action: () -> Void
    var loading: Bool = false
    
    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                Text(label)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Spacer()
            }
        }
        .padding()
        .frame(width: 250.0)
        .background(loading ? Color.blue.opacity(0.3) : Color.blue)
        .cornerRadius(35)
    }
}


#if DEBUG
struct CustomButton_Previews : PreviewProvider {
    static var previews: some View {
        
        CustomButton(label: "Sign In", action: {
            print("Hello")
        })
    }
}
#endif
