import Foundation
import Swinject
import SwinjectAutoregistration

extension Container {

  func registerViewModels() {
    autoregister(ApiDataNetworkConfig.self, initializer: ApiDataNetworkConfig.init)
    autoregister(RemoteDataSource.self, initializer: RemoteDataSource.init)
    autoregister(PlayersRepository.self, initializer: DefaultPlayersRepository.init)
    autoregister(PlayersViewModel.self, initializer: PlayersViewModel.init)
  }
}
