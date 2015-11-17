//
//  KnottTVCell.swift
//  ForgetMeKnot
//
//  Created by Rubens Gondek on 11/17/15.
//  Copyright © 2015 Knot. All rights reserved.
//

import UIKit

class KnottTVCell: UITableViewCell {

    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var on: UISwitch!
    
    var knott: Knott! {
        didSet {
            name.text = knott.name
            on.on = (knott.on == 1)
            if knott.favorite == 0 {
                favBtn.setTitleColor(UIColor.grayColor(), forState: .Normal)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func setFav(sender: AnyObject) {
        if favBtn.titleColorForState(.Normal) == UIColor(red: 209/255, green: 34/255, blue: 34/255, alpha: 1) {
            favBtn.setTitleColor(UIColor.grayColor(), forState: .Normal)
        }
        else {
            favBtn.setTitleColor(UIColor(red: 209/255, green: 34/255, blue: 34/255, alpha: 1), forState: .Normal)
        }
    }

}
