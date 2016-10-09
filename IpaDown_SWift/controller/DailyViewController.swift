//
//  DailyViewController.swift
//  IpaDown_SWift
//
//  Created by gaokunpeng on 16/8/8.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class DailyViewController: BaseViewController,MyDownloaderDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //导航
        self.addNavLabelTitle("每日一荐")
        
        //下拉刷新
        self.addFooter()
        
        self.addHeader()
        
        //返回
        self.addBackBtn(self, action: #selector(backAction))

        
        
    }
    
    
    func backAction(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
   
    override func downloadData() {
        
        ProgressHUD.showOnView(self.view)
        
        let urlString = String(format: kDailyUrl, self.pageSize!, self.curPage)
        
        let downloader = MyDownloader()
        downloader.delegate = self
        downloader.downloadWithUrlString(urlString)
        
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
extension DailyViewController {

    func downloader(downloader: MyDownloader, didFinishWithData data: NSData) {
        
        
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
    }
    
    func downloader(downloader: MyDownloader, didFailWithError error: NSError) {
        print(error)
        
        ProgressHUD.hideAfterFailOnView(self.view)
    }
    
}


//MARK: UITableView代理
extension DailyViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "limitCellId"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? LimitCell
        
        if (nil == cell) {
            
            cell = NSBundle.mainBundle().loadNibNamed("LimitCell", owner: nil, options: nil).last as? LimitCell
        }
        
        //显示数据
        let model = self.dataArray[indexPath.row] as! HomeModel
        cell?.configModel(model, atIndex: indexPath.row)
        
        return cell!
    }

    
}


