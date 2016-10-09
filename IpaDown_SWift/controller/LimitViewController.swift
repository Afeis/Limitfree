//
//  LimitViewController.swift
//  IpaDown_SWift
//
//  Created by gaokunpeng on 16/8/8.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class LimitViewController: BaseViewController, MyDownloaderDelegate {
    
    var selectIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //导航
        self.createSegmetCtrl()
        
        //下拉刷新
        self.addHeader()
        
        self.addFooter()
        
    }
    
    //导航
    func createSegmetCtrl(){
        
        let segCtrl = UISegmentedControl(items: ["今日限免","本周热门限免","热门限免总榜"])
        
        segCtrl.addTarget(self, action: #selector(clickSegCtrl(_:)), forControlEvents: .ValueChanged)
        
        //修改文字颜色
        segCtrl.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: .Normal)
        
        segCtrl.selectedSegmentIndex = 0
        
        self.navigationItem.titleView = segCtrl
    }
    
    
    func clickSegCtrl(segCtrl: UISegmentedControl){
        
        self.selectIndex = segCtrl.selectedSegmentIndex
        
        self.curPage = 1
        
        self.tbView!.contentOffset = CGPointZero
        
        self.downloadData()
    }
    
   
    override func downloadData() {
        
        ProgressHUD.showOnView(self.view)
        
        var urlString = ""
        if (self.selectIndex == 0) {
           
            urlString =  String(format: kLimitToday, self.pageSize!,self.curPage)
            
        }else if (self.selectIndex == 1){
            
            urlString =  String(format: kLimitMonth, self.pageSize!,self.curPage)
         
        }else if (self.selectIndex == 2){
            urlString =  String(format: kLimitHot, self.pageSize!,self.curPage)
        }
        
        let downloader = MyDownloader()
        downloader.type = 200
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
extension LimitViewController {
    
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
extension LimitViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 110
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




