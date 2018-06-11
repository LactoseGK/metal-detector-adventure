//
//  ViewController.swift
//  MetalDetectorAdventure
//
//  Created by Geir-Kåre S. Wærp on 08/06/2018.
//  Copyright © 2018 Geir-Kåre S. Wærp. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate {
    
    var tapped = false
    let squarePathLayer = CAShapeLayer()
    let duration = 3.5
    
    @IBOutlet weak var testView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTapBox()
    }
    
    func configureTapBox() {
        testView.backgroundColor = .gray
        
        squarePathLayer.lineWidth = 4
        squarePathLayer.fillColor = UIColor.clear.cgColor
        squarePathLayer.path = UIBezierPath(rect: testView.bounds).cgPath
        squarePathLayer.strokeEnd = 0
        
        testView.layer.addSublayer(squarePathLayer)
    }

    @IBAction func tapped(_ sender: Any) {
        guard !tapped else { return }
        guard let recognizer = sender as? UITapGestureRecognizer else { return }
        guard recognizer.state == .ended else { return }
        
        if testView.frame.contains(recognizer.location(in: self.view)) {
            startFrameAnimation()
            tapped = true
        }
    }
    
    func startFrameAnimation() {
        squarePathLayer.removeAllAnimations()
        UIView.animate(withDuration: 0.15) { [unowned self] in
            self.testView.backgroundColor = .gray
        }
        
        let strokeAnim = CABasicAnimation(keyPath: "strokeEnd")
        strokeAnim.fromValue = 0
        strokeAnim.toValue = 1
        
        let colorAnim = CABasicAnimation(keyPath: "strokeColor")
        colorAnim.fromValue = UIColor.red.cgColor
        colorAnim.toValue = UIColor.green.cgColor
        
        let animGroup = CAAnimationGroup()
        animGroup.animations = [strokeAnim, colorAnim]
        animGroup.duration = duration
        animGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animGroup.delegate = self
        
        squarePathLayer.add(animGroup, forKey: "Progress")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        tapped = false
        
        UIView.animate(withDuration: 0.2) { [unowned self] in
            self.testView.backgroundColor = .blue
        }
    }
}

