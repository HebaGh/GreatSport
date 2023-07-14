//
//  LoadingOverlay.swift
//  GreatSport
//
//  Created by mac on 7/14/23.
//



import Foundation
import UIKit

public class LoadingOverlay{

    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var bgView = UIView()

    class var shared: LoadingOverlay {
        struct Static {
            static let instance: LoadingOverlay = LoadingOverlay()
        }
        return Static.instance
    }

    public func showOverlay(view: UIView) {
        
        view.endEditing(true)
        
        bgView.frame = view.frame
        
        bgView.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        
        bgView.addSubview(overlayView)
        
        bgView.autoresizingMask = [.flexibleLeftMargin,.flexibleTopMargin,.flexibleRightMargin,.flexibleBottomMargin,.flexibleHeight, .flexibleWidth]
        
        overlayView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        
        overlayView.center = view.center
        
        overlayView.autoresizingMask = [.flexibleLeftMargin,.flexibleTopMargin,.flexibleRightMargin,.flexibleBottomMargin]
        
        overlayView.backgroundColor = UIColor.white
        
        overlayView.clipsToBounds = true
        
        overlayView.layer.cornerRadius = 10

        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        
        activityIndicator.color = UIColor(named: "PrimaryColor")
        
        activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)

        overlayView.addSubview(activityIndicator)
        
        view.addSubview(bgView)
        
        self.activityIndicator.startAnimating()

    }

    public func hideOverlayView() {
        
        activityIndicator.stopAnimating()
        
        bgView.removeFromSuperview()
    }
}
