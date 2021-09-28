//
//  SignInButton.swift
//  Shop
//
//  Created by a1 on 24.09.2021.
//

import UIKit

class SignInButton: UIButton {
    
    var originalSize: CGRect?
    
    override func awakeFromNib() {
        setup()
    }
    
    func setup() {
        backgroundColor = .red
        tintColor = .white
        layer.cornerRadius = 8
    }
    
    func animateButton(shouldLoad: Bool) {
        let sp = UIActivityIndicatorView()
        sp.style = .large
        sp.color = UIColor.white
        sp.alpha = 0.0
        sp.hidesWhenStopped = true
        sp.tag = 21
        
        if shouldLoad {
            self.addSubview(sp)
            self.setTitle("", for: .normal)
            
            UIView.animate(withDuration: 0.2, animations: {
                self.layer.cornerRadius = self.frame.height / 2
                self.frame = CGRect(x: self.frame.midX - (self.frame.height / 2), y: self.frame.origin.y, width: self.frame.height, height: self.frame.height)
            }, completion: {(finished) in
                if finished == true {
                    sp.startAnimating()
                    sp.center = CGPoint(x: self.frame.width / 2 + 1, y: self.frame.width / 2 + 1)
                    sp.fadeTo(alphaValue: 1.0, withDuration: 0.0)
                }
            })
            
            self.isUserInteractionEnabled = false
        } else {
            self.isUserInteractionEnabled = true
            
            for subview in self.subviews {
                if subview.tag == 21 {
                    subview.removeFromSuperview()
                }
            }
            
            UIView.animate(withDuration: 0.2, animations: {
                self.layer.cornerRadius = 5.0
                self.frame = self.originalSize!
                self.setTitle("", for: .normal)
            })
        }
    }

}

extension UIView {
    func fadeTo(alphaValue: CGFloat, withDuration duration: TimeInterval) {
        self.alpha = alphaValue
    }
}
