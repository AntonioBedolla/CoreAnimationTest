//
//  ViewController.swift
//  CoreAnimationTest
//
//  Created by Antonio Bedolla on 08/01/25.
//

import UIKit

class ViewController: UIViewController {

   let animatedView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Configuración de la vista animada
                animatedView.frame = CGRect(x: 100, y: 200, width: 100, height: 100)
                animatedView.backgroundColor = .blue
                view.addSubview(animatedView)

                startAnimations()
    }

    func startAnimations() {
            // Animación de rotación infinita
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotationAnimation.toValue = CGFloat.pi * 2
            rotationAnimation.duration = 2
            rotationAnimation.repeatCount = .infinity
            animatedView.layer.add(rotationAnimation, forKey: "rotation")

            // Animación de cambio de color y tamaño
            let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
            colorAnimation.toValue = UIColor.red.cgColor
            colorAnimation.duration = 2
            colorAnimation.beginTime = 0
            colorAnimation.autoreverses = true
            colorAnimation.repeatCount = .infinity

            let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
            scaleAnimation.toValue = 1.5
            scaleAnimation.duration = 2
            scaleAnimation.beginTime = 0
            scaleAnimation.autoreverses = true
            scaleAnimation.repeatCount = .infinity

            let groupAnimation = CAAnimationGroup()
            groupAnimation.animations = [colorAnimation, scaleAnimation]
            groupAnimation.duration = 2
            groupAnimation.repeatCount = .infinity
            animatedView.layer.add(groupAnimation, forKey: "colorAndScale")
        }

}
