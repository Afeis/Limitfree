//
//  HomePageViewController.swift
//  IpaDown_SWift
//
//  Created by gaokunpeng on 16/8/8.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class HomePageViewController: BaseViewController, MyDownloaderDelegate {
    
    //广告的数据
    lazy var adArray = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()

        //标题
        self.addNavLabelTitle("精品限时免费")
        
        //下拉刷新
        self.addFooter()
        
        self.addHeader()
        
        //下载广告数据
        self.downloadAdvertismentData()
        
        
    }

    
    //下载广告数据
    func downloadAdvertismentData(){
        
        let urlString = kHomeAdUrl
        
        let downloader = MyDownloader()
        downloader.type = 200
        downloader.delegate = self
        
        downloader.downloadWithUrlString(urlString)
        
    }
 
    //下载列表数据
    override func downloadData(){
        
        ProgressHUD.showOnView(self.view)
        
        let urlString = String(format: kHomeListUrl, self.pageSize!, self.curPage)
        
        let downloader = MyDownloader()
        downloader.type = 100
        downloader.delegate = self
        
        downloader.downloadWithUrlString(urlString)
    }

    //下拉刷新时额外的操作
    override func refreshHeader() {
        self.dataArray.removeAllObjects()
        self.downloadAdvertismentData()
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


extension HomePageViewController {
    
    func downloader(downloader: MyDownloader, didFailWithError error: NSError) {
        print(error)
        
        if downloader.type == 200 {
            ProgressHUD.hideAfterFailOnView(self.view)
        }
    }
    
    func downloader(downloader: MyDownloader, didFinishWithData data: NSData) {
        
        if downloader.type == 100 {
        
            if self.curPage == 1 {
                self.dataArray.removeAllObjects()
            }
            
            //JSON解析
            //解析数据
            let result = try! NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
            
            if result.isKindOfClass(NSArray.self) {
                
                let array = result as! Array<Dictionary<String,AnyObject>>
                
                for homeDict in array {
                    //创建模型对象
                    let model = HomeModel()
                    model.setValuesForKeysWithDictionary(homeDict)
                    self.dataArray.addObject(model)
                    
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.tbView?.reloadData()
                    
                    self.tbView?.headerView?.endRefreshing()
                    self.tbView?.footerView?.endRefreshing()
                    
                    ProgressHUD.hideAfterSuccessOnView(self.view)
                })
          
            }
            
        }else if downloader.type == 200 {
            
            //解析数据
            let result = try! NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)

            if result.isKindOfClass(NSArray.self) {
                
                let array = result as! Array<Dictionary<String,AnyObject>>
                
                for adDict in array {
                    //创建模型对象
                    let model = ADModel()
                    model.setValuesForKeysWithDictionary(adDict)
                    self.adArray.addObject(model)
                    
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.tbView?.reloadData()
                    
                    self.tbView?.headerView?.endRefreshing()
                    self.tbView?.footerView?.endRefreshing()
                    
                    
                })

                
            }
            
        }
        
    }
    
}


extension HomePageViewController {
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var num = self.dataArray.count
        
        if self.adArray.count > 0 {
            num += 1
        }
        return num
    }

    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var h: CGFloat = 0
        if (self.adArray.count > 0) {
            if (indexPath.row == 0) {
                h = 160
            }else{
                h = 110
            }
        }else{
            h = 110
        }
        return h
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if (self.adArray.count > 0) {
            
            if (indexPath.row == 0) {
                
                //广告
                let cellID = "adCellId"
                
                var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? ADCell
                if (nil == cell) {
                    cell = NSBundle.mainBundle().loadNibNamed("ADCell", owner: nil, options: nil).last as? ADCell
                }
                
                cell!.dataArray = self.adArray
                
                return cell!

            }else{
                //列表
                let cellId = "homeCellId"
                
                var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? HomeCell
                if (nil == cell) {
                    
                    cell = NSBundle.mainBundle().loadNibNamed("HomeCell", owner: nil, options: nil).last as? HomeCell
                }
                
                let model = self.dataArray[indexPath.row-1] as! HomeModel
                
                cell?.configModel(model, atIndex: indexPath.row-1)
                
                return cell!
            }
            
        }else{
            //列表
            let cellId = "homeCellId"
            
            var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? HomeCell
            if (nil == cell) {
                
                cell = NSBundle.mainBundle().loadNibNamed("HomeCell", owner: nil, options: nil).last as? HomeCell
            }
            
            let model = self.dataArray[indexPath.row] as! HomeModel
            
            cell?.configModel(model, atIndex: indexPath.row)
            
            return cell!
        }
     
    }
   
}


