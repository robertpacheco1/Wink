//
//  InlineAlert.swift
//  Wink
//
//  Created by Robert Pacheco on 7/12/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import SwiftUI

enum AlertIntent {
    case info, success, question, danger, warning
}

struct InlineAlert : View {
    
    var title: String
    var subtitle: String?
    var intent: AlertIntent = .info
    
    var body: some View {
        
        HStack {
            
            Image(systemName: "exclamationmark.triangle.fill")
                .padding(.vertical)
                .foregroundColor(Color.white)
            
            VStack(alignment: .leading) {
                Text(self.title)
                    .font(.body)
                .color(.white)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                
                if (self.subtitle != nil) {
                    Text(self.subtitle!)
                        .font(.body)
                        .color(.white)
                        .lineLimit(nil)
                }
                
            }.padding(.leading)
        
        }.padding()
        .background(Color.red, cornerRadius: 8)
    }
}

#if DEBUG
struct InlineAlert_Previews : PreviewProvider {
    static var previews: some View {
        InlineAlert(
            title: "Something",
            subtitle: "Something else",
            intent: .info
        ).frame(height: 300)
    }
}
#endif
