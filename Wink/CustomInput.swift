//
//  CustomInput.swift
//  Wink
//
//  Created by Robert Pacheco on 7/12/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct InputModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding()
            .border(Color(red: 0, green: 0, blue: 0, opacity: 0.15), width: 1, cornerRadius: 5)
    }
}

struct CustomInput : View {
    @Binding var text: String
    var name: String
    
    var body: some View {
        TextField(name, text: $text)
            .modifier(InputModifier())
    }
}

#if DEBUG
struct CustomInput_Previews : PreviewProvider {
    static var previews: some View {
        CustomInput(text: .constant(""), name: "Some Name")
            .padding()
    }
}
#endif
