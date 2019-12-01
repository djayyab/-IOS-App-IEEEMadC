

import UIKit

class LibraryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var rateView: UILabel!
    @IBOutlet var startButtons: [UIButton]!
    
    
    @IBOutlet weak var modelThumbnail: UIImageView!
    @IBOutlet weak var modelTitle: UILabel!
    
    
    
    @IBOutlet weak var more: UIButton!
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        print("Rated \(sender.tag) stars.")
        rateView.text = "Rated \(sender.tag) stars."
        for  button in startButtons {
            if button.tag <= sender.tag {
                button.setBackgroundImage(UIImage.init(named: "star-selected"), for: .normal)   //selectted
            } else {
                button.setBackgroundImage(UIImage.init(named: "star-not-selected"), for: .normal)    //not selectted
            }
        }
    }
    
    
    
    
    
    
}
