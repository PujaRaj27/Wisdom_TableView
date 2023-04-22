//
//  DescriptionModel.swift
//  TableViewWithCheckbox
//
//  Created by Kumar Anand on 18/04/23.
//

import Foundation
import UIKit
class DescriptionModel {
   
    var title: String?
    var isSelected: Bool?
    var description : String?
    var image : UIImage?

    init(title: String?,isSelected: Bool?,description:String,image:UIImage?){
        self.title = title
        self.isSelected = isSelected
        self.description = description
        self.image = image
        
       
       }

}
