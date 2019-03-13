//
//  TDStickyView.swift
//  TDStickyController
//
//  Created by MacMini-1 on 2/6/19.
//  Copyright © 2019 TinuDahiya. All rights reserved.
//

import UIKit

class TDStickyView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var viewRight: UIView!
    @IBOutlet weak var viewCursorSetup: UIView!
    @IBOutlet weak var viewLeft: UIView!
    //MARK:- Outlets
    //MARK:-
    @IBOutlet weak var viewCursorRight: UIView!
    @IBOutlet weak var viewCursorLeft: UIView!
    @IBOutlet weak var viewMovement: UIView!
    @IBOutlet weak var colViewSticky: UICollectionView!
    @IBOutlet weak var panGestureColView: UIPanGestureRecognizer!
    @IBOutlet weak var panGestureHeader: UIPanGestureRecognizer!
    
    //MARK:- Properties
    //MARK:-
    private let cellID = "TDStickyColViewCell"
    private var parentFrame : CGRect!
    private var topMostY : CGFloat!
    private var bottomMostY : CGFloat!
    private var bottomOffset : CGFloat = 60
    private var arrData = [TDStickyModel]()
    private var angel : CGFloat = 0
    
    //MARK:- Functions
    //MARK:-
    
    class func instanceFromNib() -> TDStickyView {
        return UINib(nibName: "TDStickyView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TDStickyView
    }
    
    func viewSetup(_ parentVC : UIViewController)  {
        
        self.arrData = TDStickyModel.getStickyModelData()
        
        topMostY = UIApplication.shared.statusBarFrame.height
        if #available(iOS 11.0, *) {
            bottomMostY =  self.safeAreaInsets.bottom + bottomOffset
        } else {
            bottomMostY = bottomOffset
        }
        
        self.frame = CGRect(x: 0, y: topMostY,
                            width: parentVC.view.frame.width,
                            height: parentVC.view.frame.height - topMostY)
        
        self.clipsToBounds = true
        let pathWithRadius = UIBezierPath(roundedRect:self.bounds, byRoundingCorners:[.topRight, .topLeft], cornerRadii: CGSize(width: 15, height: 15))
        let maskLayer = CAShapeLayer()
        maskLayer.path = pathWithRadius.cgPath
//        self.layer.mask = maskLayer
        
        parentFrame = parentVC.view.frame
        viewCursorLeft.layer.cornerRadius = viewCursorLeft.bounds.height/2
        viewCursorRight.layer.cornerRadius = viewCursorRight.bounds.height/2
        
        colViewSticky.register(UINib(nibName: cellID, bundle: nil),
                               forCellWithReuseIdentifier:  cellID)
        self.panGestureColView.isEnabled = false
        self.addToWindow()
        self.setCursors()
        self.rotateView(addAngel: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if #available(iOS 11.0, *) {
            bottomMostY =  self.safeAreaInsets.bottom + bottomOffset
        } else {
            bottomMostY = bottomOffset
        }
    }
    
   private func rotateView(addAngel : CGFloat) {
        
        let rotateToAngel = angel + addAngel
        
        guard rotateToAngel <= .pi/8 && rotateToAngel >= -.pi/8  else {
            return
        }
        angel = rotateToAngel
        let anchorPointLeft = CGPoint(x: (viewCursorLeft.frame.width - viewCursorLeft.frame.height/2)/viewCursorLeft.frame.width,
                                      y: ( viewCursorLeft.frame.height/2)/viewCursorLeft.frame.height)
        
        viewCursorLeft.setAnchorPoint(anchorPointLeft)
        
        let anchorPointRight = CGPoint(x: (viewCursorRight.frame.height/2/viewCursorRight.frame.width),
                                       y: ( viewCursorRight.frame.height/2)/viewCursorRight.frame.height)
        
        viewCursorRight.setAnchorPoint(anchorPointRight)
        
        viewCursorLeft.transform = CGAffineTransform.init(rotationAngle: rotateToAngel)
        viewCursorRight.transform = CGAffineTransform.init(rotationAngle: -rotateToAngel)
        
    }
    
    private func setCursors() {
        self.viewCursorLeft.translatesAutoresizingMaskIntoConstraints = false
        self.viewCursorRight.translatesAutoresizingMaskIntoConstraints = false
        
        let aWidthCursor : CGFloat = 40
        let aHeightCursor : CGFloat = 6
        let aCenter = CGPoint(x: self.frame.width/2,
                              y: self.viewCursorSetup.frame.height/2)
        
        self.viewCursorLeft.frame = CGRect(x: aCenter.x - aWidthCursor + aHeightCursor/2,
                                           y: aCenter.y + aHeightCursor/2,
                                           width: aWidthCursor, height: aHeightCursor)
        
        self.viewCursorRight.frame = CGRect(x: aCenter.x - aHeightCursor/2,
                                            y: aCenter.y + aHeightCursor/2,
                                            width: aWidthCursor, height: aHeightCursor)
        self.viewCursorRight.layer.cornerRadius = aHeightCursor/2
        self.viewCursorLeft.layer.cornerRadius = aHeightCursor/2
    }
    
    private func handleGesture(_ sender : UIPanGestureRecognizer)  {
        let translation = sender.translation(in: self)
        let velocity = sender.velocity(in: self)
        
        if sender.state == .changed {
            let aNewOrigin = CGPoint(x: self.frame.origin.x , y: self.frame.origin.y + translation.y)
            if aNewOrigin.y <= topMostY || aNewOrigin.y >= parentFrame.size.height - bottomMostY {
                return
            }
            self.frame.origin = aNewOrigin
            
            if aNewOrigin.y <= 60 {
                self.rotateView(addAngel: .pi/8)
            }
            else if aNewOrigin.y >= 60 && aNewOrigin.y < self.frame.height - 100 {
                self.rotateView(addAngel: 0)
            }
            else {
                self.rotateView(addAngel: -.pi/8)
            }
            
        }
        else if sender.state == .ended {
            self.panGestureColView.isEnabled = false
            if velocity.y > 0 {
                // go down
                UIView.animate(withDuration: 0.3) {
                    self.frame = CGRect(origin: CGPoint(x: 0, y: self.parentFrame.size.height - self.bottomMostY), size: self.frame.size)
                }
            }
            else if velocity.y < 0 {
                // go up
                UIView.animate(withDuration: 0.3) {
                    self.frame = CGRect(origin: CGPoint(x: 0, y: self.topMostY), size: self.frame.size)
                }
            }
        }
        sender.setTranslation(CGPoint.zero, in: self)
        
        
        
    }
    
    //MARK:- Pan Gesture
    //MARK:-
    @IBAction func viewMovementPanGesture(_ sender: UIPanGestureRecognizer) {
        self.handleGesture(sender)
    }
    
    @IBAction func colViewMovementPanGesture(_ sender: UIPanGestureRecognizer) {
        self.handleGesture(sender)
    }
    
    //MARK:- CollectionView
    //MARK:-
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if !self.colViewSticky.isDragging && self.colViewSticky.contentOffset.y <= 0 {
            self.panGestureColView.isEnabled = true
        }
        else {
            self.panGestureColView.isEnabled = false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let aWidth = self.bounds.width/2 - 30
        let aHeight = aWidth + 50
        return CGSize(width: aWidth, height: aHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! TDStickyColViewCell
        
        cell.imgView.image = UIImage(named: self.arrData[indexPath.row].imgName)
        cell.lblName.text = self.arrData[indexPath.row].name
        cell.lblCategory.text = self.arrData[indexPath.row].category
        
        return cell
    }
}
