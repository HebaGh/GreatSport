//
//  LoadableFromXibView.swift
//  GreatSport
//
//  Created by mac on 7/15/23.
//


import UIKit

protocol NibDefinable {
    var serializedNibName: String { get }
}

class LoadableFromXibView: UIView, NibDefinable {
    
    @IBOutlet weak var view : UIView!
    
    var bundle: Bundle? {
        return Bundle.main
    }
    
    var serializedNibName: String {
        return String(describing: type(of: self))
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        xibSetup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        view = loadViewFromXib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundColor = .clear
        addSubview(view)
    }
    
    fileprivate func loadViewFromXib() -> UIView {
        let nib = UINib(nibName: serializedNibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    
    static var serializedNibNameForType: String {
        return String(describing: self)
    }
    
    class func loadView() -> UIView {
        let nib = UINib(nibName: serializedNibNameForType, bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
}

