//
//  WeaponCell.swift
//  guraburucalc
//
//  Created by Ryuichi Takayama on 2019/02/16.
//  Copyright © 2019 takayamashi. All rights reserved.
//

import UIKit

class WeaponCell: UITableViewCell {
    
    @IBOutlet weak var CellView: UIView!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Lv: UILabel!
    @IBOutlet weak var SLv: UILabel!
    @IBOutlet weak var f_skill: UILabel!
    @IBOutlet weak var s_skill: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
        // Initialization code
        self.CellView.layer.cornerRadius = 10.0
        self.CellView.layer.borderColor  =  UIColor.lightGray.cgColor
        self.CellView.layer.borderWidth = 1.0
        self.CellView.layer.masksToBounds = true
        self.CellView.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.shadowOpacity = 0.23
        self.layer.shadowColor =  UIColor.lightGray.cgColor
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSize(width:0, height: 0)
        self.layer.masksToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCardView(){
        self.backgroundColor = UIColor.clear
        self.CellView.backgroundColor = UIColor.white
        self.CellView.layer.cornerRadius = 10.0
        self.CellView.layer.shadowOpacity = 0.5
        self.CellView.layer.shadowColor =  UIColor.lightGray.cgColor
        self.CellView.layer.shadowRadius = 5.0
        self.CellView.layer.shadowOffset = CGSize(width:5, height: 5)
        self.CellView.layer.masksToBounds = true
    }

}
