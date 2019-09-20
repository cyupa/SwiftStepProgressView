//
//  StepProgressViewLayer.swift
//  SwiftStepProgress
//
//  Created by Ciprian Redinciuc on 20/09/2019.
//  Copyright © 2019 cyupa. All rights reserved.
//

import UIKit
import QuartzCore

class StepProgressViewLayer: CALayer {

    /// The number of steps the progress view layer will have
    var steps: Int = 3 {
        didSet {
            setNeedsDisplay()
        }
    }

    // The current step
    var currentStep: Int = 0 {
        didSet {
            setNeedsDisplay()
        }
    }

    // If the drawing should happen only to the current step.
    var drawUpToCurrentStep: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }

    /// The internal padding in points
    var padding: CGFloat = 5 {
        didSet {
            setNeedsDisplay()
        }
    }

    /// The fill color of the path
    var fillColor: CGColor? = nil {
        didSet {
            setNeedsDisplay()
        }
    }

    /// The path line width
    var lineWidth: CGFloat = 1.0 {
        didSet {
            setNeedsDisplay()
        }
    }

    /// The stroke color of the path
    var strokeColor: CGColor? = UIColor.blue.cgColor {
        didSet {
            setNeedsDisplay()
        }
    }

    /// The total number of steps that need to be drawn
    private var totalSteps: Int {
        guard drawUpToCurrentStep else {
            return steps
        }

        guard currentStep < steps else {
            return steps
        }

        return currentStep + 1
    }

    /// The total width available for drawing
    private var drawingWidth: CGFloat {
        return bounds.size.width - 2 * padding
    }

    /// The total height available for drawing
    private var drawingHeight: CGFloat {
        return bounds.size.height - 2 * padding
    }

    /// The radius for drawing the circles
    private var circleRadius: CGFloat {
        return drawingHeight / 2
    }

    /// The lenght between the circles
    private var connectingLineLenght: CGFloat {
        let remainingLenght = drawingWidth - (CGFloat(steps) * 2 * circleRadius)
        return remainingLenght / CGFloat(steps - 1)
    }

    override init() {
        super.init()
        needsDisplayOnBoundsChange = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        needsDisplayOnBoundsChange = true
    }

    override func draw(in ctx: CGContext) {
        // Draw the path
        ctx.beginPath()

        // Set the line width
        ctx.setLineWidth(lineWidth)

        // Create the path
        createTopPath(in: ctx, with: circleRadius, steps: totalSteps)
        if totalSteps > 1 {
            createBottomPath(in: ctx, with: circleRadius, steps: totalSteps)
        }
        
        ctx.closePath()

        if let fillColor = fillColor {
            ctx.setFillColor(fillColor)
            ctx.fillPath()
        }

        // Color the path
        if let strokeColor = strokeColor {
            ctx.setStrokeColor(strokeColor)
            ctx.strokePath()
        }
    }

    private func createTopPath(in context: CGContext, with circleRadius: CGFloat, steps: Int) {
        let radUnit = CGFloat.pi / 6
        // Define the start angles
        var startAngleRad = steps == 0 ? 0 : radUnit
        var endAngleRad =  steps == 0 ? 2 * CGFloat.pi : 11 * radUnit

        // Calculate the first center
        let startCenter = calculaCircleCenter(for: 0)

        // Draw the first open circle from the left, counterclockwise
        context.addArc(center: startCenter,
                       radius: circleRadius,
                       startAngle: startAngleRad,
                       endAngle: endAngleRad,
                       clockwise: false)
        if steps > 1 {
            // For every intermediary point
            startAngleRad = endAngleRad - 4 * radUnit

            for index in 1..<steps-1 {
                // Calculate the center
                let centerPoint = calculaCircleCenter(for: index)

                // Calculate where the line between circles should end by using
                // the point on the next circle where the line stops
                let lineEndPointX = centerPoint.x + circleRadius * cos(startAngleRad)
                let lineEndPointY = centerPoint.y + circleRadius * sin(startAngleRad)
                let lineEndPoint = CGPoint(x: lineEndPointX, y: lineEndPointY)

                // Draw the line to the next circle
                context.addLine(to: lineEndPoint)

                // Draw the next circle's top arc
                context.addArc(center: centerPoint,
                               radius: circleRadius,
                               startAngle: startAngleRad,
                               endAngle: endAngleRad,
                               clockwise: false)
            }
            // Calculate the center of the circle on the most right hand side
            let centerPoint = calculaCircleCenter(for: steps-1)

            // Move the end point to the bottom
            endAngleRad = 5 * radUnit

            // Create the circle on the most right hand side
            context.addArc(center: centerPoint,
                           radius: circleRadius,
                           startAngle: startAngleRad,
                           endAngle: endAngleRad,
                           clockwise: false)
        }
    }

    private func createBottomPath(in context: CGContext, with circleRadius: CGFloat, steps: Int) {
        // Define the start angles
        let radUnit = CGFloat.pi / 6
        let startAngleRad = radUnit
        let endAngleRad =  5 * radUnit

        // Going back from left to right
        for index in (1..<steps-1).reversed() {
            // Calculate the center
            let centerPoint = calculaCircleCenter(for: index)

            // Calculate where the line between circles should end by using
            // the point on the next circle where the line stops
            let lineEndPointX = centerPoint.x + circleRadius * cos(startAngleRad)
            let lineEndPointY = centerPoint.y + circleRadius * sin(startAngleRad)
            let lineEndPoint = CGPoint(x: lineEndPointX, y: lineEndPointY)

            // Draw the line to the next circle
            context.addLine(to: lineEndPoint)

            // Draw the next circle's top arc
            context.addArc(center: centerPoint,
                           radius: circleRadius,
                           startAngle: startAngleRad,
                           endAngle: endAngleRad,
                           clockwise: false)
        }
    }

    private func calculaCircleCenter(for step: Int) -> CGPoint {
        // Doing this to help the Swift compiler
        let totalLinesLenght = CGFloat(step) * (2 * circleRadius + connectingLineLenght)
        let xPoint = padding + totalLinesLenght + circleRadius
        let yPoint = drawingHeight / 2 + padding
        return CGPoint(x: xPoint, y: yPoint)
    }
}
