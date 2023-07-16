import Foundation
import Swinject
import SwinjectAutoregistration

extension Container {
  
    func registerUseCases() {
        autoregister(FetchPlayersUseCase.self, initializer: DefaultFetchPlayersUseCase.init)
    }
}
