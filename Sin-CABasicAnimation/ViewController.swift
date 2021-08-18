//
//  ViewController.swift
//  Sin-CABasicAnimation
//
//  Created by 大西玲音 on 2021/08/18.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var myTopView: UIView!
    @IBOutlet private weak var myView: UIView!
    @IBOutlet private weak var myTopView2: UIView!
    @IBOutlet private weak var myView2: UIView!
    @IBOutlet private weak var myTopView3: UIView!
    @IBOutlet private weak var myView3: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    private var initCount: Int?
    private var color: UIColor { .systemRed.withAlphaComponent(0.5) }
    private var color2: UIColor { .systemPink.withAlphaComponent(0.3) }
    private var color3: UIColor { .systemBlue.withAlphaComponent(0.2) }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        self.view.backgroundColor = .white
        myView.backgroundColor = .clear
        myTopView.backgroundColor = color
        myView2.backgroundColor = .clear
        myTopView2.backgroundColor = color2
        myView3.backgroundColor = .clear
        myTopView3.backgroundColor = color3

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if initCount == nil {
            myView.cutToSinCurve(waveCount: 1.2, amplitude: 10, color: color)
            myView2.cutToSinCurve(waveCount: 2, amplitude: 7, color: color2)
            myView3.cutToSinCurve(waveCount: 0.9, amplitude: 9, color: color3)
            initCount = 1
        }
        
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = String(indexPath.row)
        return cell!
    }
    
    
}

extension UIView {
    
    func cutToSinCurve(waveCount: Double, amplitude: Double, color: UIColor) {
        let layer = CAShapeLayer()
        layer.frame = CGRect(x: 0,
                             y: 0,
                             width: self.frame.width,
                             height: self.frame.height)
        layer.fillColor = color.cgColor
        layer.strokeColor = color.cgColor
        layer.lineWidth = 3
        layer.path = createSinPath(layer: layer, waveCount: waveCount, amplitude: amplitude)
        if let layer = self.layer.sublayers?.first {
            layer.removeFromSuperlayer()
        }
        self.layer.addSublayer(layer)
    }
    
    private func createSinPath(layer: CAShapeLayer, waveCount: Double, amplitude: Double) -> CGPath {
        let div: Double = 1 / 100
        let sinPath = UIBezierPath()
        let originX: CGFloat = layer.lineWidth
        let origin = CGPoint(x: -originX,
                             y: layer.frame.height / 2)
        let count = waveCount * 2
        let xRatioToFill = Double(layer.frame.width) / (Double.pi / div)
        sinPath.move(to: CGPoint(x: origin.x, y: 0))
        sinPath.addLine(to: CGPoint(x: origin.x, y: origin.y))
        for i in 0...Int(Double.pi / div * count) {
            let x = div * Double(i)
            let y = sin(x)
            sinPath.addLine(to: CGPoint(x: (x / div / count + Double(origin.x)) * xRatioToFill + Double(originX * 2),
                                        y: Double(origin.y) * (1 - y / amplitude))
            )
        }
        sinPath.addLine(to: CGPoint(x: layer.frame.width + originX, y: 0))
        return sinPath.cgPath
    }
    
}
