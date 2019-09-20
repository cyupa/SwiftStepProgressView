//
//  SwiftStepProgressViewSpec.swift
//  SwiftStepProgressView
//
//  Created by Ciprian Redinciuc on 01/04/19.
//  Copyright © 2019 cyupa. All rights reserved.
//

import Quick
import Nimble
@testable import SwiftStepProgressView

class SwiftStepProgressSpec: QuickSpec {
    override func spec() {
        describe("SwiftStepProgressViewSpec") {
            it("works") {
                expect(SwiftStepProgressView.name) == "SwiftStepProgressView"
            }
        }
    }
}
