import UIKit

enum Destination {
    case home
    case search
}

protocol Coordinator {
    var navigationController: UINavigationController { get set }   
    func pop()
    func push(destination : Destination )
}

