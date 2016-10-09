//
//  MainTabBarController.swift
//  IpaDown_SWift
//
//  Created by gaokunpeng on 16/8/8.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //创建视图控制器
        self.createViewControllers()
        
    }
    
    
    func createViewControllers() {

        let ctrlArray = ["IpaDown_SWift.HomePageViewController","IpaDown_SWift.LimitViewController","IpaDown_SWift.CategoryViewController","IpaDown_SWift.RecommendViewController","IpaDown_SWift.MoreViewController"]
        let titleArray = ["首页","今日限免","分类","推荐","更多"]
        let imageArray = ["item_app_home","item_app_pricedrop","item_app_category","item_app_hot","item_app_more"]
        
        
        var array = Array<UINavigationController>()
        
        for i in 0..<ctrlArray.count {
            //创建试图控制器
            let clsName = ctrlArray[i]
            let cls = NSClassFromString(clsName) as! UIViewController.Type
            
            let ctrl = cls.init()
            ctrl.tabBarItem.title = titleArray[i]
            ctrl.tabBarItem.image = UIImage(named: imageArray[i])
        
            let navCtrl = UINavigationController(rootViewController: ctrl)
            
            array.append(navCtrl)
        }
       
        
        self.viewControllers = array
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
