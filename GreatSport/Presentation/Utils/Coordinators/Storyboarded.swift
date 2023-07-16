import Foundation
import UIKit

enum StoryboardName {
    case Main
  
    var description : String {
       switch self {
       // Use Internationalization, as appropriate.
       case .Main: return "Main"
       }
     }
}
protocol Storyboarded {
    static func instantiate(storyboard : StoryboardName) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(storyboard : StoryboardName = .Main) -> Self {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(self)

        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]

        // load our storyboard
        let storyboard = UIStoryboard(name: storyboard.description, bundle: Bundle.main)

        // instantiate a view controller with that identifier, and force cast as the type that was requested
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
