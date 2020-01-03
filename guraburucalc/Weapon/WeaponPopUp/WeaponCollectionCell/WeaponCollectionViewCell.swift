//
//  WeaponCollectionViewCell.swift
//  guraburucalc
//
//  Created by Ryuichi Takayama on 2019/02/18.
//  Copyright © 2019 takayamashi. All rights reserved.
//

import UIKit

class WeaponCollectionViewCell: UICollectionViewCell, PrototypeViewSizing {
    @IBOutlet weak var PopUpBar: UIView!
    @IBOutlet weak var WeaponName: UILabel!
    @IBOutlet weak var Skill1: UILabel!
    @IBOutlet weak var Skill2: UILabel!
    @IBOutlet weak var Element: UIButton!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
