import UIKit
class PrevViewControllerSegue: UIStoryboardSegue {
    override func perform() {
        if (identifier == "actionNoAnimated") {
            source.navigationController?.popViewController(animated: false)
        }
        else {
            source.navigationController?.popViewController(animated: true)
        }
    }
}
