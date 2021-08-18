//
//  ViewController.swift
//  Sin-CABasicAnimation
//
//  Created by 大西玲音 on 2021/08/18.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var myView: UIView!
    @IBOutlet private weak var myTopView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        myView.backgroundColor = .clear
        myTopView.backgroundColor = .systemRed.withAlphaComponent(0.5)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        myView.cutToSinCurve()
        
        
    }
    
}

extension UIView {
    
    func cutToSinCurve() {
        let layer = CAShapeLayer()
        layer.frame = CGRect(x: 0,
                             y: 0,
                             width: self.frame.width,
                             height: self.frame.height)
        layer.fillColor = UIColor.systemRed.withAlphaComponent(0.5).cgColor
        layer.path = createSinPath(frame: layer.frame)
        self.layer.addSublayer(layer)
    }
    
    private func createSinPath(frame: CGRect) -> CGPath {
        let div: Double = 1 / 100
        let sinPath = UIBezierPath()
        let origin = CGPoint(x: 0,
                             y: frame.height / 2)
        let count: Double = 2
        let xRatioToFill = Double(frame.width) / (Double.pi / div)
        sinPath.move(to: CGPoint(x: origin.x, y: 0))
        sinPath.addLine(to: CGPoint(x: origin.x, y: origin.y))
        for i in 0...Int(Double.pi / div * count) {
            let x = div * Double(i)
            let y = sin(x)
            sinPath.addLine(
                to: CGPoint(x: (x / div / count + Double(origin.x)) * xRatioToFill,
                            y: Double(origin.y) * (1 - y))
            )
        }
        sinPath.addLine(to: CGPoint(x: frame.width, y: 0))
        return sinPath.cgPath
    }
    
}
