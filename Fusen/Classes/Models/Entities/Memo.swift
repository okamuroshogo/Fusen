//
//  Memo.swift
//  Fusen
//
//  Created by shogo okamuro on 2017/04/01.
//  Copyright © 2017 ro.okamu. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift
import Realm

class Memo: Object {
    static let realm = try! Realm()
    dynamic var id          : Int      = 0
    dynamic var title       : String      = ""
    dynamic private var imageData: Data? {
        set {
            self.imageData = newValue
        }
        get {
            guard let image = self.image else { return nil }
            return UIImagePNGRepresentation(image)
        }
    }
    dynamic var image: UIImage? {
        set{
            self.image = newValue
            if let value = newValue {
                self.imageData = UIImagePNGRepresentation(value)
            }
        }
        get{
            if let image = self.image {
                return image
            }
            if let data = self.imageData {
                self.image = UIImage(data: data)
                return self.image
            }
            return nil
        }
    }
    
    required init() {
        super.init()
    }
    
    convenience init(title: String) {
        self.init()
        self.id = Memo.lastId()
        self.title = title
    }
    
    override static func ignoredProperties() -> [String] {
        return ["image", "_image"]
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    static func create() -> Memo {
        let memo = Memo()
        memo.id = lastId()
        return memo
    }
 
    static func lastId() -> Int {
        if let memo = realm.objects(Memo.self).last {
            return memo.id + 1
        } else {
            return 1
        }
    }
 
}


