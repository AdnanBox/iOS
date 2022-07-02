//
//  Shapes.swift
//  SoloSET
//
//  Created by Adnan Boxwala on 25.06.22.
//

import SwiftUI

struct Diamond: Shape {
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let width = 0.65 * rect.width
        let height = width / 2
        
        let firstPoint = CGPoint(
            x: center.x,
            y: center.y + height / 2
        )
        let secondPoint = CGPoint(
            x: center.x - width / 2,
            y: center.y
        )
        let thirdPoint = CGPoint(
            x: center.x,
            y: center.y - (height / 2)
        )
        let fourthPoint = CGPoint(
            x: center.x + width / 2,
            y: center.y
        )
        
        var p = Path()
        p.move(to: firstPoint)
        p.addLine(to: secondPoint)
        p.addLine(to: thirdPoint)
        p.addLine(to: fourthPoint)
        p.addLine(to: firstPoint)
        
        return p
    }
}

struct MyCapsule: Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let width = 0.65 * rect.width
        let height = width / 2
        
        let startPoint = CGPoint(
            x: center.x - width / 4,
            y: center.y - height / 2
        )
        let curveLeft = CGPoint(
            x: center.x - width / 4,
            y: center.y
        )
        let curveRight = CGPoint(
            x: center.x + width / 4,
            y: center.y
        )
        
        var p = Path()
        p.addArc(center: curveLeft, radius: height / 2, startAngle: Angle(degrees: 270), endAngle: Angle(degrees: 90), clockwise: true)
        p.addArc(center: curveRight, radius: height / 2, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 270), clockwise: true)
        p.addLine(to: startPoint)

        return p
    }
}

struct Zapper: Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let width = 0.65 * rect.width
        let height = width / 2
        
        let firstPoint = CGPoint(
            x: center.x - width / 2,
            y: center.y
        )
        let secondPoint = CGPoint(
            x: center.x,
            y: center.y - height / 2
        )
        let thirdPoint = CGPoint(
            x: center.x,
            y: center.y + height / 2
        )
        let fourthPoint = CGPoint(
            x: center.x + width / 2,
            y: center.y
        )
        
        var p = Path()
        p.move(to: firstPoint)
        p.addLine(to: secondPoint)
        p.addLine(to: thirdPoint)
        p.addLine(to: fourthPoint)
        p.addLine(to: firstPoint)

        return p
    }
}
