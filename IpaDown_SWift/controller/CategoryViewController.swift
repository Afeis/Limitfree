//
//  CategoryViewController.swift
//  IpaDown_SWift
//
//  Created by gaokunpeng on 16/8/8.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class CategoryViewController: BaseViewController, MyDownloaderDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //标题
        self.addNavLabelTitle("按分类筛选")
        
        //表格
        self.createTableView()
        
        
        //下载
        self.downloadData()
        
    }
    
    override func downloadData() {
        
        ProgressHUD.showOnView(self.view)
        
        
        let urlString = kCategoryListUrl
       
        let downloader = MyDownloader()
        downloader.type = 200
        downloader.delegate = self
        
        downloader.downloadWithUrlString(urlString)
        
    }
    
    func refreshUI(){
        
        self.tbView?.reloadData()
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

//MARK: MyDownloader代理
extension CategoryViewController {
    
    func downloader(downloader: MyDownloader, didFinishWithData data: NSData) {
        
        
        //JSON解析
        //解析数据
        let result = try! NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
        
        let str = NSString(data: data, encoding: NSUTF8StringEncoding)
        print(str)
        
        if result.isKindOfClass(NSArray.self) {
            
            let array = result as! Array<Dictionary<String,AnyObject>>
            
            for cateDict in array {
                //创建模型对象
                let model = CategoryModel()
                model.setValuesForKeysWithDictionary(cateDict)
                
                
                
                let listArray = cateDict["list"] as! Array<Dictionary<String,AnyObject>>
                let typeArray = NSMutableArray()
                for listDict in listArray {
                    let typeModel = CategoryType()
                    typeModel.setValuesForKeysWithDictionary(listDict)
                    typeArray.addObject(typeModel)
                }
                
                model.typeArray = typeArray
                
                self.dataArray.addObject(model)
                
            }
           
            dispatch_async(dispatch_get_main_queue(), {
                self.tbView?.reloadData()
                
                self.tbView?.headerView?.endRefreshing()
                self.tbView?.footerView?.endRefreshing()
                
                ProgressHUD.hideAfterSuccessOnView(self.view)
            })
            
            
            
            
        }
    }
    
    func downloader(downloader: MyDownloader, didFailWithError error: NSError) {
        print(error)
        
        ProgressHUD.hideAfterFailOnView(self.view)
    }
    
}


extension CategoryViewController {
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.dataArray.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = self.dataArray[section] as! CategoryModel
        return (model.typeArray?.count)!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "categoryCellId"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CategoryCell
        if nil == cell {
            cell = NSBundle.mainBundle().loadNibNamed("CategoryCell", owner: nil, options: nil).last as? CategoryCell
        }
        
        let model = self.dataArray[indexPath.section] as! CategoryModel
        let typeModel = model.typeArray![indexPath.row] as! CategoryType
        
        cell?.config(typeModel)
        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = self.dataArray[section] as! CategoryModel
        return model.header
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let model = self.dataArray[indexPath.section] as! CategoryModel
        let typeModel = model.typeArray![indexPath.row] as! CategoryType
        
        let listCtrl = CateListViewController()
        listCtrl.categoryStr = typeModel.querystr
        
        listCtrl.cateName = typeModel.title
        
        self.navigationController?.pushViewController(listCtrl, animated: true)
        
    }
    
    

    
}
