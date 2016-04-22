//
//  ViewController.swift
//  Mask
//
//  Created by Brad G. on 4/21/16.
//  Copyright © 2016 Brad G. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bottomView2: UIView!
    @IBOutlet weak var topView2: UIView!
    @IBOutlet weak var movableView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var topView: UIView!
    var movableCenter = CGPoint(x: 77.0, y: 354.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movableView.layer.cornerRadius = self.movableView.frame.size.height * 0.5
        self.movableView.layer.borderColor = UIColor.blackColor().CGColor
        self.movableView.layer.borderWidth = 2.0
        self.bottomView.layer.cornerRadius = self.bottomView.frame.size.height * 0.5
        self.topView.layer.cornerRadius = self.topView.frame.size.height * 0.5
        self.bottomView2.layer.cornerRadius = self.bottomView.frame.size.height * 0.5
        self.topView2.layer.cornerRadius = self.topView.frame.size.height * 0.5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pan(sender: UIPanGestureRecognizer) {
        self.movableView.center.x = sender.translationInView(self.view).x + self.movableCenter.x
        self.movableView.center.y = sender.translationInView(self.view).y + self.movableCenter.y
        if CGRectIntersectsRect(self.movableView.frame, self.topView.frame)
        {
            self.topView.layer.mask = nil
            let shapeLayer = CAShapeLayer()
            let rect = self.topView.convertRect(self.movableView.bounds, fromView: self.movableView)
            let path = UIBezierPath(ovalInRect: rect)
            let maskPath = CGPathCreateMutable()
            CGPathAddRect(maskPath, nil, self.view.frame)
            CGPathAddPath(maskPath, nil, path.CGPath)
            shapeLayer.path = maskPath
            shapeLayer.fillRule = kCAFillRuleEvenOdd
            self.topView.layer.mask = shapeLayer
        }
        //would be better to not repeat code like this
        if CGRectIntersectsRect(self.movableView.frame, self.topView2.frame)
        {
            self.topView2.layer.mask = nil
            let shapeLayer = CAShapeLayer()
            let rect = self.topView2.convertRect(self.movableView.bounds, fromView: self.movableView)
            let path = UIBezierPath(ovalInRect: rect)
            let maskPath = CGPathCreateMutable()
            CGPathAddRect(maskPath, nil, self.view.frame)
            CGPathAddPath(maskPath, nil, path.CGPath)
            shapeLayer.path = maskPath
            shapeLayer.fillRule = kCAFillRuleEvenOdd
            self.topView2.layer.mask = shapeLayer
        }
        if sender.state == .Ended
        {
            self.movableCenter = self.movableView.center
        }
    }

}

