//
//  Spinner.swift
//  Wink
//
//  Created by Robert Pacheco on 7/14/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import SwiftUI

struct SpinnerView: View {
    
    @State private var fillPoint = 0.0
    @State private var colorIndex = 0
    
    let duration = 0.8
    
    var colors: [Color] = [.red, .green, .blue, .yellow]
    
    private var animation: Animation {
        Animation.basic(duration: duration).repeatForever(autoreverses: false)
    }
    
    private var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: duration, repeats: true) { _ in
            if self.colorIndex + 1 >= self.colors.count {
                self.colorIndex = 0
            } else {
                self.colorIndex += 1
            }
        }
    }
    
    var body: some View {
        Ring(fillPoint: fillPoint).stroke(colors[colorIndex], lineWidth: 10)
            .frame(width: 50, height: 50)
            .onAppear() {
                withAnimation(self.animation) {
                    self.fillPoint = 1.0
                    _ = self.timer
                }
        }
    }
}
struct Ring: Shape {
    var fillPoint: Double
    var delayPoint: Double = 0.5
    
    var animatableData: Double   {
        get { return fillPoint }
        set { fillPoint = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var start: Double
        let end = 360 * fillPoint
        
        if fillPoint > delayPoint {
            start = (2 * fillPoint) * 360
        } else {
            start = 0
        }
        
        var path = Path()
        path.addArc(center: CGPoint(x: rect.size.width/2, y: rect.size.height/2),
                    radius: rect.size.width/2,
                    startAngle: .degrees(start),
                    endAngle: .degrees(end),
                    clockwise: false)
        
        return path
    }
    
    
}

#if DEBUG
struct SpinnerView_Previews : PreviewProvider {
    static var previews: some View {
        SpinnerView()
    }
}
#endif
