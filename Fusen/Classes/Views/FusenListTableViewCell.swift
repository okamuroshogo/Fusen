//
//  FusenListTableViewCell.swift
//  Fusen
//
//  Created by shogo okamuro on 2017/04/01.
//  Copyright © 2017 ro.okamu. All rights reserved.
//

import UIKit
import SwipeCellKit


class FusenListTableViewCell: SwipeTableViewCell {
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var fusenIV: UIImageView!

    var memo: Memo? {
        didSet {
            self.label.text = memo?.title
            self.fusenIV.image = memo?.image
            let a = memo?.image
            print(a)
        }
    }
    
}
