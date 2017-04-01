//
//  MemoModel.swift
//  Fusen
//
//  Created by shogo okamuro on 2017/04/01.
//  Copyright © 2017 ro.okamu. All rights reserved.
//

import Foundation
import Bond

struct MemoModel {
    static func create() -> Memo {
        let memo = Memo.create()
        memo.title = "新規メモ\(Memo.lastId())"
        memo.save()
        MemoViewModel.sharedInstance.memoList.value.append(memo)
        return memo
    }
    
    static func remove(at: Int) {
        let memo = MemoViewModel.sharedInstance.memoList.value[at]
        memo.delete()
    }
}
