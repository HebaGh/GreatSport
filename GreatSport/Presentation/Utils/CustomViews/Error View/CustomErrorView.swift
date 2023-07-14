import Foundation
import UIKit

protocol CustomErrorViewDelegate  {
  func didTapRetry()
}

class CustomErrorView: UIView {
  
  @IBOutlet weak var errorMessage: UILabel!
  @IBOutlet weak var submitView: CardView!
  
  var delegate: CustomErrorViewDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    submitView.delegate = self
  }
}

extension CustomErrorView: CardViewDelegate {
  func didTap(cardView: CardView) {
    self.delegate?.didTapRetry()
  }
}
