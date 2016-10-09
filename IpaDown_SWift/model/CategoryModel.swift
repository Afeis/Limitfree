//
//  CategoryModel.swift
//  IpaDown_SWift
//
//  Created by gaokunpeng on 16/8/8.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class CategoryModel: NSObject {
    
    var header: String?
    
    var typeArray: NSArray?
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }

}


class CategoryType: NSObject {
    
    var desc: String?
    var icon: String?
    var querystr: String?
    var title: String?
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}
