//
//  descTableViewCell.swift
//  TableViewWithCheckbox
//
//  Created by Kumar Anand on 18/04/23.
//

import UIKit

class descTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    
        private let checked = UIImage(named: "ic_Select")//ic_radioEmpty
        private let unchecked = UIImage(named: "ic_radioEmpty")//ic_Select
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public func configure(_ text: String) {
            titleLabel.text = text
        //descLabel.text = te
        }


    @IBOutlet weak var checkboxBtn: UIButton!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func isSelected(_ selected: Bool) {
            setSelected(selected, animated: false)
            let image = selected ? checked : unchecked
        checkboxBtn.setImage(image, for: .normal)//.image = image
        }
    
}
