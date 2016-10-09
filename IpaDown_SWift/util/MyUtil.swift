//
//  MyUtil.swift
//  IpaDown_SWift
//
//  Created by gaokunpeng on 16/8/8.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class MyUtil: NSObject {
    //标签
    class func createLabel(frame: CGRect, text: String?) -> UILabel {
        
        let label = UILabel(frame: frame)
        if text != nil {
            label.text = text
        }
        
        return label
    }
    
    //图片视图
    class func createImageView(frame: CGRect, imageName: String?) -> UIImageView {
        let imageView = UIImageView(frame: frame)
        if imageName != nil {
            imageView.image = UIImage(named: imageName!)
        }
        return imageView
    }
    
    //按钮
    class func createBtn(frame: CGRect, title: String?, bgImageName: String?, target:AnyObject?, action: Selector) -> UIButton{
        
        let btn = UIButton(type: .Custom)
        btn.frame = frame
        if title != nil {
            btn.setTitle(title, forState: .Normal)
            btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        }
        
        //背景图片
        if bgImageName != nil {
            btn.setBackgroundImage(UIImage(named: bgImageName!), forState: .Normal)
        }
        
        //点击事件
        if target != nil && action != nil {
            btn.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        }
        
        return btn
    }
    
    class func transferCateName(name: String) -> String {
        
        var result = ""
        if name == "Business" {
            result = "商业"
        }else if name == "Weather" {
            result = "天气"
        }else if name == "Tool" {
            result = "工具"
        }else if name == "Travel" {
            result = "旅行"
        }else if name == "Sports" {
            result = "体育"
        }else if name == "Social" {
            result = "社交"
        }else if name == "Refer" {
            result = "参考"
        }else if name == "Ability" {
            result = "效率"
        }else if name == "Photography" {
            result = "摄影"
        }else if name == "News" {
            result = "新闻"
        }else if name == "Gps" {
            result = "导航"
        }else if name == "Music" {
            result = "音乐"
        }else if name == "Life" {
            result = "生活"
        }else if name == "Health" {
            result = "健康"
        }else if name == "Finance" {
            result = "财务"
        }else if name == "Pastime" {
            result = "娱乐"
        }else if name == "Education" {
            result = "教育"
        }else if name == "Book" {
            result = "书籍"
        }else if name == "Medical" {
            result = "医疗"
        }else if name == "Catalogs" {
            result = "商品指南"
        }else if name == "FoodDrink" {
            result = "美食"
        }else if name == "Game" {
            result = "游戏"
        }else if name == "All" {
            result = "全部"
        }
        
        return result
    }
    
    
    //弹出提示框的方法
    class func showAlert(msg: String, onViewController vc: UIViewController) {
        
        let alertCtrl = UIAlertController(title: "提示", message: msg, preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "确定", style: .Default, handler: nil)
        alertCtrl.addAction(action)
        
        vc.presentViewController(alertCtrl, animated: true, completion: nil)
        
    }

}
