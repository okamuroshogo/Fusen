//
//  MemoViewModel.swift
//  Fusen
//
//  Created by shogo okamuro on 2017/04/01.
//  Copyright © 2017 ro.okamu. All rights reserved.
//

import Foundation
import Bond
class MemoViewModel: NSObject {
    class var sharedInstance: MemoViewModel { struct Singleton { static let instance: MemoViewModel = MemoViewModel() }; return Singleton.instance }
    var memoList: Observable<[Memo]> = Observable([])
    
    override init() {
        super.init()
        self.memoList.value = Memo.all()
    }
}
