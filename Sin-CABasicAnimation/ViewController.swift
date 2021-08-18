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
    @IBOutlet private weak var waveCountLabel: UILabel!
    @IBOutlet private weak var amplitudeLabel: UILabel!
    @IBOutlet weak var amplitudeSlider: UISlider!
    
    private var verticalBorderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    private var horizontalBorderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    private var initCount: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        myView.backgroundColor = .clear
        myTopView.backgroundColor = .red
        amplitudeSlider.value = amplitudeSlider.maximumValue
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if initCount == nil {
            myView.cutToSinCurve(waveCount: 1, amplitude: 10)
            initCount = 1
        }
        myView.layer.borderWidth = 2
        myView.layer.borderColor = UIColor.black.cgColor
        setupBorderView()
        
    }
    
    @IBAction private func waveCountSliderValueDidChanged(_ sender: UISlider) {
        let value = Int(sender.value)
        waveCountLabel.text = String(value)
    }
    
    @IBAction private func amplitudeSliderValueDidChanged(_ sender: UISlider) {
        let value = Int(sender.value)
        amplitudeLabel.text = String(value)
    }
    
    @IBAction private func goButtonDidTapped(_ sender: Any) {
        myView.cutToSinCurve(waveCount: Double(waveCountLabel.text!)!,
                             amplitude: Double(amplitudeLabel.text!)!)
    }
    
    private func setupBorderView() {
        self.view.addSubview(verticalBorderView)
        NSLayoutConstraint.activate([
            verticalBorderView.widthAnchor.constraint(equalToConstant: 2),
            verticalBorderView.centerXAnchor.constraint(equalTo: myView.centerXAnchor),
            verticalBorderView.topAnchor.constraint(equalTo: myView.topAnchor),
            verticalBorderView.bottomAnchor.constraint(equalTo: myView.bottomAnchor)
        ])
        self.view.addSubview(horizontalBorderView)
        NSLayoutConstraint.activate([
            horizontalBorderView.heightAnchor.constraint(equalToConstant: 2),
            horizontalBorderView.centerYAnchor.constraint(equalTo: myView.centerYAnchor),
            horizontalBorderView.leadingAnchor.constraint(equalTo: myView.leadingAnchor),
            horizontalBorderView.trailingAnchor.constraint(equalTo: myView.trailingAnchor)
        ])
    }
    
}

extension UIView {
    
    func cutToSinCurve( waveCount: Double, amplitude: Double) {
        let layer = CAShapeLayer()
        layer.frame = CGRect(x: 0,
                             y: 0,
                             width: self.frame.width,
                             height: self.frame.height)
        layer.fillColor = UIColor.red.cgColor
        layer.path = createSinPath(frame: layer.frame, waveCount: waveCount, amplitude: amplitude)
        if let layer = self.layer.sublayers?.first {
            layer.removeFromSuperlayer()
        }
        self.layer.addSublayer(layer)
    }
    
    private func createSinPath(frame: CGRect, waveCount: Double, amplitude: Double) -> CGPath {
        let div: Double = 1 / 100
        let sinPath = UIBezierPath()
        let origin = CGPoint(x: 0,
                             y: frame.height / 2)
        let count = waveCount * 2
        let xRatioToFill = Double(frame.width) / (Double.pi / div)
        sinPath.move(to: CGPoint(x: origin.x, y: 0))
        sinPath.addLine(to: CGPoint(x: origin.x, y: origin.y))
        for i in 0...Int(Double.pi / div * count) {
            let x = div * Double(i)
            let y = sin(x)
            sinPath.addLine(to: CGPoint(x: (x / div / count + Double(origin.x)) * xRatioToFill,
                                        y: Double(origin.y) * (1 - y * amplitude / 10))
            )
            print(amplitude)
        }
        sinPath.addLine(to: CGPoint(x: frame.width, y: 0))
        return sinPath.cgPath
    }
    
}
