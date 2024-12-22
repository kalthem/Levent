
import SDWebImage
import UIKit
extension UIImageView {
    func setImage(with urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            // Do nothing if the URL is invalid or nil
            return
        }
        self.sd_setImage(with: url, completed: nil)
    }
}
