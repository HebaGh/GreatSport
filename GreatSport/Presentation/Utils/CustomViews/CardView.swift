import Foundation
import UIKit
import pop

@objc protocol CardViewDelegate  {
  func didTap(cardView : CardView)
}

class CardView: UIView {
  
  @IBOutlet var delegate : CardViewDelegate?
  //Shadow
  @IBInspectable var shadowEnabled : Bool = true
  @IBInspectable var shadowColor : UIColor = .black
  //Border
  @IBInspectable var borderEnabled : Bool = false
  
  @IBInspectable var animationEnabled = true
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setUpView()
  }
  
  func setUpView() {
    
    self.clipsToBounds = true
    self.layer.cornerRadius = cornerRadius
    
    if shadowEnabled {
      self.clipsToBounds = false
      self.layer.shadowColor = UIColor.clear.cgColor
      self.layer.shadowOffset = CGSize(width: 0, height: 0.5)
      self.layer.shadowOpacity = 0.2
      self.layer.shadowRadius = 3
    }
    if borderEnabled {
      self.layer.borderColor = self.borderColor.cgColor
      self.layer.borderWidth = self.borderWidth
    }
  }
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if animationEnabled {
      let scaleAnimation = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
      scaleAnimation?.duration = 0.1
      scaleAnimation?.fromValue = NSValue(cgPoint: CGPoint(x: 1, y: 1))
      scaleAnimation?.toValue = NSValue(cgPoint: CGPoint(x: 0.95, y: 0.95))
      self.pop_add(scaleAnimation, forKey: "startAnimation")
    }
  }
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    if animationEnabled {
      let springAnimation = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
      springAnimation?.fromValue = NSValue(cgPoint: CGPoint(x: 0.95, y: 0.95))
      springAnimation?.toValue = NSValue(cgPoint: CGPoint(x: 1, y: 1))
      springAnimation?.velocity = NSValue(cgPoint: CGPoint(x: 2, y: 2))
      springAnimation?.springBounciness = 7.0
      self.pop_add(springAnimation, forKey: "endAnimation")
    }
    if self.bounds.contains((touches.first?.location(in: self))!) {
      self.delegate?.didTap(cardView: self)
    }
    
  }
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    if animationEnabled {
      let scaleAnimation = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
      scaleAnimation?.fromValue = NSValue(cgPoint: CGPoint(x: 0.95, y: 0.95))
      scaleAnimation?.toValue = NSValue(cgPoint: CGPoint(x: 1, y: 1))
      scaleAnimation?.duration = 0.1
      self.pop_add(scaleAnimation, forKey: "cancelAnimation")
    }
  }
  func cancelAnimations() {
    self.pop_removeAllAnimations()
    
    let scaleAnimation = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
    scaleAnimation?.fromValue = NSValue(cgPoint: CGPoint(x: 1, y: 1))
    scaleAnimation?.toValue = NSValue(cgPoint: CGPoint(x: 1, y: 1))
    scaleAnimation?.duration = 0.0
    self.pop_add(scaleAnimation, forKey: "resetAnimation")
    
  }
}
