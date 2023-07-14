//
//  BaseViewController.swift
//  GreatSport
//
//  Created by mac on 7/14/23.
//

import UIKit

class BaseViewController: UIViewController {
  
  let errorViewTag = 10
  
  // show overlay loading
  func showFullScreenLoading()  {
    LoadingOverlay.shared.showOverlay(view: self.view)
  }
  
  // hide overlay loading
  func finishFullScreenLoading()  {
    LoadingOverlay.shared.hideOverlayView()
  }
  
  // show error view with retry button on the center of the screen
  public func showFullScreenError(view: UIView, message: String = "" , title : String = "" , delegate : CustomErrorViewDelegate) {
    
    let allviews = Bundle.main.loadNibNamed("CustomErrorView", owner: self, options: nil)

    if let errorView = allviews?.first as? CustomErrorView {
      errorView.delegate = delegate
      errorView.errorMessage.text = message
      errorView.tag = errorViewTag
      errorView.center =  CGPoint(x: self.view.frame.width  / 2,
                                  y: ( self.view.frame.height)  / 2)
      view.addSubview(errorView)
      
    }
  }
  
  // remove error view
  public func hideFullScreenError() {
    if let errorView = self.view.viewWithTag(errorViewTag) {
      errorView.removeFromSuperview()
    }
  }
  
}
