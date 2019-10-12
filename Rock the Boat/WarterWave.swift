//
//  WarterWave.swift
//  Rock the Boat
//
//  Created by wxc on 2019/10/12.
//  Copyright © 2019 wxc. All rights reserved.
//

import UIKit

class WarterWave: UIView,UICollisionBehaviorDelegate {

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
    
    var dropView : UIView!
    var dropView2 : UIView!
    var dropView3 : UIView!
    var boot : UIImageView!
    var fish : UIImageView!
    var animator : UIDynamicAnimator!
    var push : UIPushBehavior!
    var grav : UIGravityBehavior!
    var coll : UICollisionBehavior!
 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.waterWaveWidth  = Int(frame.size.width)
        self.waterWaveHeight = Int(frame.size.height/2)
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
        boot.frame = CGRect.init(x: 20, y: 12, width: 20, height: 20)
        boot.tag = 100
        boot.backgroundColor = .clear
        self.addSubview(boot)
        
        animator = UIDynamicAnimator.init(referenceView: self)
        
        grav = UIGravityBehavior.init(items: [boot])
        animator.addBehavior(grav)
        
        coll = UICollisionBehavior.init(items: [boot])
        coll.collisionDelegate = self
        animator.addBehavior(coll)
        
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(fishJump), userInfo: nil, repeats: true)
        
    }
    
}
