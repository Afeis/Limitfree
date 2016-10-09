//
//  MyNavViewController.swift
//  IpaDown_SWift
//
//  Created by gaokunpeng on 16/8/8.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class MyNavViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func addNavLabelTitle(title: String) {
        
        let label = MyUtil.createLabel(CGRectMake(80, 20, 215, 44), text: title)
        label.font = UIFont.boldSystemFontOfSize(28)
        label.textAlignment = .Center
        
        self.navigationItem.titleView = label
        
    }
    
    
    func addBackBtn(target: AnyObject, action: Selector) {
        
        let btn = MyUtil.createBtn(CGRectMake(0, 0, 60, 36), title: "返回", bgImageName: "backButton", target: target, action: action)
        let item = UIBarButtonItem(customView: btn)
        
        self.navigationItem.leftBarButtonItem = item
        
    }
    

    func addNavBtnTitle(title: String, bgImageName: String, target: AnyObject,action: Selector) -> UIButton{
        
        let btn = MyUtil.createBtn(CGRectMake(0, 0, 60, 36), title: title, bgImageName: bgImageName, target: target, action: action)
        
        let item = UIBarButtonItem(customView: btn)
        
        self.navigationItem.rightBarButtonItem = item
        
        return btn
    }
    
    



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
