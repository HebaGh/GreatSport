import UIKit

class MainCoordinator: Coordinator {
  
  var navigationController: UINavigationController
  static var shared : MainCoordinator?
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func push(destination: Destination) {
    
  }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
    
    func pushPlayersPage()
    {
        let vc = PlayersViewController(nibName: "PlayersViewController", bundle: nil)
        vc.viewModel = AppDelegate.container.resolve(PlayersViewModel.self)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func pushPlayersDetails(player:Player)
    {

        let vc = ArticleDetailsViewController(nibName: "ArticleDetailsViewController", bundle: nil)
        vc.article = article
        self.navigationController.pushViewController(vc, animated: true)
    }
    
}
