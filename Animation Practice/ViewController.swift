//
//  ViewController.swift
//  Animation Practice
//
//  Created by Denis Bystruev on 28/06/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var button: UIButton!
    @IBOutlet var centerX: NSLayoutConstraint!
    
    var animator: UIViewPropertyAnimator!
    let initialFrame = CGRect(x: 0, y: 0, width: 100, height: 100)
    var square: UIView!
    var numberOfTouches = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        square = UIView(frame: initialFrame)
        square.backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        
        view.addSubview(square)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        numberOfTouches += 1
        
        print(#line, #function, "numberOfTouches =", numberOfTouches)
        
        let width = view.frame.width
        let height = view.frame.height
        
        let minimizeTransform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        let maximizeTransform = CGAffineTransform(scaleX: 2, y: 2)
        let rotateTransform = CGAffineTransform(rotationAngle: .pi / 4)
        let translateTranform = CGAffineTransform(translationX: width / 2, y: height / 2)
        let comboTransform = minimizeTransform.concatenating(rotateTransform).concatenating(translateTranform).concatenating(maximizeTransform)
        
        switch numberOfTouches {
            
        case 1:
            animator = UIViewPropertyAnimator(duration: 2, curve: .easeInOut) {
                self.square.center.x = width / 2
                self.square.center.y = height / 2
            }
            animator.addCompletion { _ in
                self.square.frame = self.initialFrame
            }
            animator.startAnimation()
            
        case 2:
            animator.addAnimations {
                self.square.layer.cornerRadius = 15
            }
            animator.startAnimation()
            
        case 3:
            animator.addAnimations {
                self.square.transform = maximizeTransform
            }
            animator.addCompletion { position in
                self.square.transform = rotateTransform
            }
            animator.startAnimation()
        case 4:
            UIView.animate(withDuration: 2, animations: {
                self.square.transform = comboTransform
            }, completion: { _ in
                UIView.animate(withDuration: 2, animations: {
                    self.square.transform = .identity
                })
            })
            
        case 5:
            UIView.animate(withDuration: 2, delay: 0, options: [.autoreverse], animations: {
                self.square.backgroundColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
            })
            
        default:
            UIView.animate(withDuration: 2, animations: {
                self.square.frame = CGRect(x: width / 4, y: height / 4, width: 200, height: 200)
            }) { _ in
                UIView.animate(withDuration: 2, animations: {
                    self.square.frame = self.initialFrame
                })
            }
            
            numberOfTouches = 0
            
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        centerX.constant = 100
        UIView.animate(withDuration: 5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: [.autoreverse], animations: {
            self.view.layoutIfNeeded()
        }) { _ in
            self.centerX.constant = 0
        }
    }
    
}

