//
//  WarterWave.swift
//  Rock the Boat
//
//  Created by wxc on 2019/10/12.
//  Copyright © 2019 wxc. All rights reserved.
//

import UIKit

class WarterWave: UIView {

    let pathPadding     = 30
    let waveSpeed       = 6
    let waveAmplitude   = 6
    var waterWaveHeight = 200
    var waterWaveWidth  = 200
    var offsetX  = 1

    var l : CALayer!
    var fishFirstColl : Bool = true
    var waveDisplaylink : CADisplayLink!
    var waveLayer : CAShapeLayer!
    var waveBoundaryPath : UIBezierPath!

    var boot : UIImageView!
    
    var animator : UIDynamicAnimator!
    var push : UIPushBehavior!
    var grav : UIGravityBehavior!
    var coll : UICollisionBehavior!
 
    private lazy var fish : UIImageView = {
        let fish = UIImageView.init(frame: CGRect.zero)
        fish.image = UIImage.init(named: "fish")
        fish.tag = 101
        fish.backgroundColor = UIColor.clear
        return fish
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.waterWaveWidth  = Int(frame.size.width)
        self.waterWaveHeight = Int(frame.size.height/2)
        self.addSubview(fish)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WarterWave {
    
    func stop() -> Void {
        waveDisplaylink.invalidate()
        waveDisplaylink = nil
    }
    
    @objc func getCurrentWave(displayLink:CADisplayLink) -> Void{
        coll.removeAllBoundaries()
        offsetX = offsetX + waveSpeed
        waveBoundaryPath = getgetCurrentWavePath()
        waveLayer.path = waveBoundaryPath.cgPath
        coll!.addBoundary(withIdentifier: NSString.init(string: "waveBoundary"), for: waveBoundaryPath)
    }
    
    func getgetCurrentWavePath() -> UIBezierPath {
        let p = UIBezierPath.init()
        let path : CGMutablePath = CGMutablePath()
        
        path.move(to: CGPoint.init(x: 0, y: waterWaveHeight))
        
        var y = 0.0
        
        for x in 0...waterWaveWidth {
            let r = Double(offsetX) * Double.pi / 180
            let u = Double(x) * (Double.pi / 180)
            let t = Double(360/waterWaveWidth) * Double(u) - r
            y = Double((Float(waveAmplitude) * sinf(Float(t))) + Float(waterWaveHeight))
            path.addLine(to: CGPoint.init(x: Double(x), y: y))
        }
        path.addLine(to: CGPoint.init(x: Double(waterWaveWidth), y: 400))
        path.addLine(to: CGPoint.init(x: 0, y: 400))
        path.closeSubpath()
        
        p.cgPath = path
        
        return p
    }
    
    @objc func fishJump() -> Void{
        fish.isHidden = false
        fishFirstColl = false
        
        fish.frame = CGRect.init(x: waterWaveWidth - pathPadding - 30, y: waterWaveHeight , width: 30, height: 30)
        
        let trackPath = UIBezierPath.init()
        let startP = CGPoint.init(x: CGFloat(pathPadding) + fish.frame.size.width / 2, y: fish.center.y)
        trackPath.move(to: startP)
        trackPath.addQuadCurve(to: fish.center, controlPoint: CGPoint.init(x: (fish.center.x - startP.x)/2 + startP.x, y: fish.center.y - 100))
        
        let fishAnim = CAKeyframeAnimation.init(keyPath: "position")
        fishAnim.path = trackPath.cgPath
        fishAnim.rotationMode = .rotateAuto
        fishAnim.timingFunction = CAMediaTimingFunction.init(controlPoints: 0.1, 0.4, 0.9, 0.6)
        fishAnim.duration = 1
        fishAnim.isRemovedOnCompletion = false
        fishAnim.fillMode = .forwards
        fish.layer.add(fishAnim, forKey: "fishAnim")
        
        animator = UIDynamicAnimator.init(referenceView: self)
               
        grav = UIGravityBehavior.init(items: [boot])
        animator.addBehavior(grav)
       
        coll = UICollisionBehavior.init(items: [boot])
        animator.addBehavior(coll)
    }
 
}

extension WarterWave {
    
    func wave() -> Void {
        
        waveBoundaryPath = UIBezierPath.init()
        waveLayer = CAShapeLayer.init()
        waveLayer.fillColor = UIColor.init(red: 0, green: 0.722, blue: 1, alpha: 1).cgColor
        self.layer.addSublayer(waveLayer)
        
        waveDisplaylink = CADisplayLink.init(target: self, selector: #selector(getCurrentWave(displayLink:)))
        waveDisplaylink.add(to: RunLoop.main, forMode: RunLoop.Mode.common)
        
        boot = UIImageView.init(image: UIImage.init(named: "ship"))
        boot.frame = CGRect.init(x: waterWaveWidth/2 - 40, y: waterWaveHeight/2, width: 20, height: 20)
        boot.tag = 100
        boot.backgroundColor = .clear
        self.addSubview(boot)
        
        let opacityAni = CABasicAnimation.init(keyPath: "opacity")
        opacityAni.fromValue = NSNumber.init(value: 0.5)
        opacityAni.toValue = NSNumber.init(value: 1)
        opacityAni.duration = 4
        opacityAni.fillMode = .forwards
        opacityAni.repeatCount = HUGE
        opacityAni.isRemovedOnCompletion = false
        boot.layer.add(opacityAni, forKey: "opacityAnimation")
        
        animator = UIDynamicAnimator.init(referenceView: self)
        
        grav = UIGravityBehavior.init(items: [boot])
        animator.addBehavior(grav)
        
        coll = UICollisionBehavior.init(items: [boot])
        animator.addBehavior(coll)
        
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(fishJump), userInfo: nil, repeats: true)
        
    }
    
}
