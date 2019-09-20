//
//  SwiftStepProgressView.swift
//  SwiftStepProgressView
//
//  Created by Ciprian Redinciuc on 01/04/19.
//  Copyright © 2019 cyupa. All rights reserved.
//

import UIKit

@IBDesignable public class SwiftStepProgressView: UIView {
    /// The number of steps the progress view layer will have
    @IBInspectable public var steps: Int = 3 {
        didSet {
            outerLayer.steps = steps
            innerLayer.steps = steps
        }
    }

    /// The number of steps the progress view layer will have
    @IBInspectable public var currentStep: Int = 0 {
        didSet {
            innerLayer.currentStep = currentStep
        }
    }

    /// The outer path padding in points relative to the margins
    @IBInspectable public var outerCirclePadding: CGFloat = 5 {
        didSet {
            outerLayer.padding = outerCirclePadding
            innerLayer.padding = outerCirclePadding + innerCirclePadding
        }
    }

    /// The inner path padding in points relative to the outer path
    @IBInspectable public var innerCirclePadding: CGFloat = 6 {
        didSet {
            innerLayer.padding = outerCirclePadding + innerCirclePadding
        }
    }

    /// The stroke color of the outer path
    @IBInspectable public var strokeColor: CGColor? = UIColor.blue.cgColor {
        didSet {
            outerLayer.strokeColor = strokeColor
        }
    }

    /// The fill color of the inner path
    @IBInspectable public var fillColor: CGColor? = UIColor.blue.cgColor {
        didSet {
            innerLayer.fillColor = fillColor
        }
    }

    private var outerLayer: StepProgressViewLayer
    private var innerLayer: StepProgressViewLayer

    public override init(frame: CGRect) {
        outerLayer = StepProgressViewLayer()
        innerLayer = StepProgressViewLayer()
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        outerLayer = StepProgressViewLayer(coder: aDecoder) ?? StepProgressViewLayer()
        innerLayer = StepProgressViewLayer(coder: aDecoder) ?? StepProgressViewLayer()
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        outerLayer.frame = bounds
        outerLayer.lineWidth = 2.0
        outerLayer.padding = outerCirclePadding
        layer.addSublayer(outerLayer)

        innerLayer.frame = bounds
        innerLayer.fillColor = UIColor.blue.cgColor
        innerLayer.padding = outerCirclePadding + innerCirclePadding
        innerLayer.currentStep = 0
        innerLayer.drawUpToCurrentStep = true
        layer.addSublayer(innerLayer)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        outerLayer.frame = bounds
        innerLayer.frame = bounds
    }
}
