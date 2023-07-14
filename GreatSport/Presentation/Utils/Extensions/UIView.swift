//
//  UIView.swift
//  GreatSport
//
//  Created by mac on 7/14/23.
//

import Foundation
import UIKit
import AudioToolbox

extension UIView {
    
    @IBInspectable open var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable open var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable open var borderColor : UIColor {
        get { return UIColor(cgColor: layer.borderColor ?? UIColor.white.cgColor) }
        set { layer.borderColor = newValue.cgColor }
    }
    
    public class func fromNib<T: UIView>(bundle: Bundle?) -> T {
        return bundle?.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    public func shakeView() {
        
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.03
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 5, y: self.center.y))
        self.layer.add(animation, forKey: "position")
        
    }
    
    public func randomize(interval: TimeInterval, withVariance variance: Double) -> Double {
        let random = (Double(arc4random_uniform(1000)) - 500.0) / 500.0
        return interval + variance * random
    }
    
    public func startWiggle() {
        
        let wiggleBounceY = 4.0
        let wiggleBounceDuration = 0.12
        let wiggleBounceDurationVariance = 0.025
        
        let wiggleRotateAngle = 0.06
        let wiggleRotateDuration = 0.10
        let wiggleRotateDurationVariance = 0.025
        
        //Create rotation animation
        let rotationAnim = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotationAnim.values = [-wiggleRotateAngle, wiggleRotateAngle]
        rotationAnim.autoreverses = true
        rotationAnim.duration = randomize(interval: wiggleRotateDuration, withVariance: wiggleRotateDurationVariance)
        rotationAnim.repeatCount = HUGE
        
        //Create bounce animation
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        bounceAnimation.values = [wiggleBounceY, 0]
        bounceAnimation.autoreverses = true
        bounceAnimation.duration = randomize(interval: wiggleBounceDuration, withVariance: wiggleBounceDurationVariance)
        bounceAnimation.repeatCount = HUGE
        
        //Apply animations to view
        UIView.animate(withDuration: 0) {
            self.layer.add(rotationAnim, forKey: "rotation")
            self.layer.add(bounceAnimation, forKey: "bounce")
            self.transform = .identity
        }
    }
    
    public func stopWiggle() {
        self.layer.removeAllAnimations()
    }
    
    public func drawShadow(spread:CGFloat, blur:CGFloat, yPostion:CGFloat = 25, opacity: Float = 0.2, width: CGFloat? = nil, height: CGFloat? = nil, shadowCornerRadious: CGFloat? = nil, showOnTop: Bool = true, color: UIColor = .black) {
        
        let spreadActualValue = spread == 0 ? 1 : spread
        
        let height = height ?? self.frame.height
        let width = width ?? self.frame.width
        
        let radius: CGFloat = height - yPostion
        
        let rect = CGRect(x: 0, y: 0, width: width, height: spreadActualValue * radius)
        
        var shadowPath = UIBezierPath(rect: rect)
        
        if let cornerRadious = shadowCornerRadious {
            
            shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadious)
            
        }
        
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: yPostion)
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = blur
        self.layer.masksToBounds =  false
        self.layer.shadowPath = shadowPath.cgPath
        if showOnTop {
            self.layer.zPosition = 9999
        }
        
    }
    
    public func drawShadow(shadowSize: CGFloat = 1.0, frame: CGRect? = nil, color: UIColor = .black, shadowOpacity: Float = 0.1, showAboveAll: Bool = true) {
        
        let rect = frame ?? CGRect(x: -shadowSize / 2, y: -shadowSize / 2, width: self.frame.size.width, height: self.frame.size.height - 20)
        
        let shadowPath = UIBezierPath(rect: rect)
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowPath = shadowPath.cgPath
        if showAboveAll {
            self.layer.zPosition = 9999
        }
        
    }
    
    public func addDashedLineBorderWithColor(color: UIColor, borderWidth: CGFloat, dimension: CGFloat? = nil, lineDashPattern: [NSNumber]? = nil) {
        
        _ = self.layer.sublayers?.filter({$0.name == "DashedBorder"}).map({$0.removeFromSuperlayer()})
        let  border = CAShapeLayer()
        border.name = "DashedBorder"
        border.strokeColor = color.cgColor
        border.fillColor = nil
        border.lineWidth = borderWidth
        border.lineDashPattern = lineDashPattern ?? [10, 5, 5, 5]
        self.layoutIfNeeded()
        self.setNeedsLayout()
        let bounds = CGRect(x: 0, y: 0, width: dimension ?? self.bounds.width, height: dimension ?? self.bounds.height)
        border.path = UIBezierPath.init(roundedRect: bounds, cornerRadius: dimension ?? self.bounds.width / 2).cgPath
        border.frame = bounds
        self.layer.addSublayer(border)
        
    }
    
    
    func makeCustomRoundBorder(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0 , borderColor: UIColor = UIColor.lightGray) {
        let minX = bounds.minX
        let minY = bounds.minY
        let maxX = bounds.maxX
        let maxY = bounds.maxY
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: minX + topLeft, y: minY))
        path.addLine(to: CGPoint(x: maxX - topRight, y: minY))
        path.addArc(withCenter: CGPoint(x: maxX - topRight, y: minY + topRight), radius: topRight, startAngle:CGFloat(3 * Double.pi / 2), endAngle: 0, clockwise: true)
        path.addLine(to: CGPoint(x: maxX, y: maxY - bottomRight))
        path.addArc(withCenter: CGPoint(x: maxX - bottomRight, y: maxY - bottomRight), radius: bottomRight, startAngle: 0, endAngle: CGFloat(Double.pi / 2), clockwise: true)
        path.addLine(to: CGPoint(x: minX + bottomLeft, y: maxY))
        path.addArc(withCenter: CGPoint(x: minX + bottomLeft, y: maxY - bottomLeft), radius: bottomLeft, startAngle: CGFloat(Double.pi / 2), endAngle: CGFloat(Double.pi), clockwise: true)
        path.addLine(to: CGPoint(x: minX, y: minY + topLeft))
        path.addArc(withCenter: CGPoint(x: minX + topLeft, y: minY + topLeft), radius: topLeft, startAngle: CGFloat(Double.pi), endAngle: CGFloat(3 * Double.pi / 2), clockwise: true)
        path.close()
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        
        layer.mask = mask
        
        // Add border
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path // Reuse the Bezier path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = 1
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }
    
    public func removeDashedBorderLayer() {
        
        _ = self.layer.sublayers?.filter({$0.name == "DashedBorder"}).map({$0.removeFromSuperlayer()})
        
    }
    
    public func createDottedLine(width: CGFloat, color: CGColor, lineDashPattern: [NSNumber]? = nil) {
        
        let caShapeLayer = CAShapeLayer()
        caShapeLayer.strokeColor = color
        caShapeLayer.lineWidth = width
        caShapeLayer.lineDashPattern = lineDashPattern
        let cgPath = CGMutablePath()
        let cgPoint = [CGPoint(x: 0, y: 0), CGPoint(x: self.frame.width, y: 0)]
        cgPath.addLines(between: cgPoint)
        caShapeLayer.path = cgPath
        layer.addSublayer(caShapeLayer)
    }
    
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        
        self.layer.mask = mask
    }
    
    public func pulse() {
        
        UIView.animate(withDuration: 0.1, animations: {
            
            self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            
        }, completion: { _ in
            
            UIView.animate(withDuration: 0.1) {
                self.transform = CGAffineTransform.identity
            }
            
        })
        
    }
    
    public func applyCircularShadowToUIView(opacity: CGFloat, blur: CGFloat, width: CGFloat = 0 , height: CGFloat = 0) {
        
        let radius: CGFloat = self.frame.width / 2.0
        let shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: radius)
        self.layer.cornerRadius = radius
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: width, height: height)  //Here you control x and y
        self.layer.shadowOpacity = Float(opacity)
        self.layer.shadowRadius = blur //Here your control your blur
        self.layer.masksToBounds =  false
        self.layer.shadowPath = shadowPath.cgPath
    }
    
    public func applyShadowToUIView(color: UIColor = .black, opacity: CGFloat, blur: CGFloat, width: CGFloat = 0 , height: CGFloat = 0) {
        
        self.clipsToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: width, height: height)  //Here you control x and y
        self.layer.shadowOpacity = Float(opacity)
        self.layer.masksToBounds =  false
        self.layer.shadowRadius = blur //Here your control your blur
    }
    
    public func addCornerRadiusAnimation(from: CGFloat, toValue: CGFloat, duration: CFTimeInterval) {
        
        let animation = CABasicAnimation(keyPath:"cornerRadius")
        
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        animation.fromValue = from
        
        animation.toValue = toValue
        
        animation.duration = duration
        
        self.layer.add(animation, forKey: "cornerRadius")
        
        self.layer.cornerRadius = toValue
        
    }
    
    public func flip() {
        self.transform = CGAffineTransform(scaleX: -1, y: 1)
    }
    
    public var globalPoint :CGPoint? {
        return self.superview?.convert(self.frame.origin, to: nil)
    }

    public var globalFrame :CGRect? {
        return self.superview?.convert(self.frame, to: nil)
    }
    
    func rotate(withAngle: Double, duration:Float = 0.3, withCount:Float = 1) {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: withAngle)
        rotation.duration = 0.3
        rotation.isCumulative = false
        rotation.repeatCount = withCount
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         layer.mask = mask
     }
    
    
    func setShadowWithColorAndCorner(color: UIColor?, opacity: Float?, offset: CGSize?, radius: CGFloat, viewCornerRadius: CGFloat?) {
        //layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: viewCornerRadius ?? 0.0).cgPath
        layer.shadowColor = color?.cgColor ?? UIColor.black.cgColor
        layer.shadowOpacity = opacity ?? 1.0
        layer.shadowOffset = offset ?? CGSize.zero
        layer.shadowRadius = radius
        
        // layer.rasterizationScale = 0.5
    }
    
    
    
    
}
