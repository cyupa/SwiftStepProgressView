//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import SwiftStepProgress

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let frame = CGRect(x: 50, y: 50, width: 200, height: 30)
        let stepProgressView = SwiftStepProgressView(frame: frame)
        stepProgressView.steps = 4
        stepProgressView.currentStep = 1
        
        view.addSubview(stepProgressView)
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
