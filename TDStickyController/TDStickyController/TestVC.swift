//
//  TestVC.swift
//  TDStickyController
//
//  Created by MacMini-1 on 2/8/19.
//  Copyright © 2019 TinuDahiya. All rights reserved.
//

import UIKit

class TestVC: UIViewController {

    @IBOutlet weak var viewRight: UIView!
    @IBOutlet weak var viewLeft: UIView!
    @IBOutlet weak var viewMakeRound: UIView!
    @IBOutlet weak var viewSupport: UIView!
    
    var aCenter = CGPoint.zero
    
    var angel : CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        viewLeft.layer.cornerRadius = viewLeft.frame.height/2
        viewRight.layer.cornerRadius = viewRight.frame.height/2
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        self.viewMakeRound.layer.cornerRadius = self.viewMakeRound.frame.width/2
        self.rotateView(angel)
    }
    
    func rotateView(_ addAngel : CGFloat) {
        
        let rotateToAngel = angel + addAngel
        
        guard rotateToAngel <= 0.6 && rotateToAngel >= -0.6  else {
            return
        }
        angel = rotateToAngel
        let anchorPointLeft = CGPoint(x: (viewLeft.frame.width - viewLeft.frame.height/2)/viewLeft.frame.width,
                                      y: ( viewLeft.frame.height/2)/viewLeft.frame.height)
        
        viewLeft.setAnchorPoint(anchorPointLeft)
        
        let anchorPointRight = CGPoint(x: (viewRight.frame.height/2/viewRight.frame.width),
                                       y: ( viewRight.frame.height/2)/viewRight.frame.height)
        
        viewRight.setAnchorPoint(anchorPointRight)
        
        
        self.viewLeft.transform = CGAffineTransform.init(rotationAngle: rotateToAngel)
        self.viewRight.transform = CGAffineTransform.init(rotationAngle: -rotateToAngel)
        
    }

    func performRoundAnimation() {
        let newButtonWidth: CGFloat = 40
        
        UIView.animate(withDuration: 0.3) {
            self.viewMakeRound.frame = CGRect(x: 0, y: 0, width: newButtonWidth, height: newButtonWidth)
            self.viewMakeRound.center = self.viewSupport.center
            self.viewMakeRound.layer.cornerRadius = newButtonWidth/2
        }
    }
    
    @IBAction func btnResetAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.viewMakeRound.frame = self.viewSupport.frame
            self.viewMakeRound.center = self.viewSupport.center
            self.viewMakeRound.layer.cornerRadius = 0
        }
    }
    
    @IBAction func btnRoundAction(_ sender: UIButton) {
        
        self.performRoundAnimation()
    }
    
    @IBAction func btnUpAction(_ sender: Any) {
        rotateView(.pi/30)
    }
    
    @IBAction func btnDownAction(_ sender: Any) {
        rotateView(-.pi/30)
    }
    
}

