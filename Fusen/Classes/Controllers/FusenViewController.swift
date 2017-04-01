//
//  FusenViewController.swift
//  Fusen
//
//  Created by shogo okamuro on 2017/04/01.
//  Copyright © 2017 ro.okamu. All rights reserved.
//

import UIKit
import EPSignature

class FusenViewController: UIViewController {
    let memoView = EPSignatureView()
    var memo: Memo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.memoView.frame = self.view.frame
        self.view.addSubview(self.memoView)
        
    }
    
}
