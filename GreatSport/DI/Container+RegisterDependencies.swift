import Foundation
import Swinject

extension Container {
    
  func registerDependencies() {
        registerViewModels()
        registerUseCases()
    }
}
