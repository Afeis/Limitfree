//
//  CateListViewController.swift
//  IpaDown_SWift
//
//  Created by gaokunpeng on 16/8/8.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class CateListViewController: BaseViewController, MyDownloaderDelegate {
    
    //查询条件
    var categoryStr: String?
    
    var cateName: String?
    
    //筛选按钮
    var chooseBtn: UIButton?
    
    //选中的序号
    var selectIndex: Int = 0
    
    var segCtrl: UISegmentedControl?
    
    //筛选的视图
    var maskView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //导航
        self.addNavLabelTitle(self.cateName!)
        
        self.addBackBtn(self, action: #selector(backAction))
       
        
        
        //下拉刷新
        self.addFooter()
        
        self.addHeader()
        
        //选择条件
        self.chooseBtn = self.addNavBtnTitle("全部", bgImageName: "navButton", target: self, action: #selector(clickBtn))
        
    }
    
    
    func clickBtn(){
        
        
        if self.chooseBtn?.currentTitle == "取消" {
            
            self.segCtrl?.removeFromSuperview()
            self.segCtrl = nil
            
            self.maskView?.removeFromSuperview()
            self.maskView = nil
            
            
            //修改按钮文字
            let title = self.segCtrl?.titleForSegmentAtIndex(self.selectIndex)
            self.chooseBtn?.setTitle(title, forState: .Normal)
            
            
            
        }else{
            
            //显示筛选界面
            self.maskView = UIView(frame: CGRectMake(0, 0, 375, 667-64-49))
            self.maskView?.backgroundColor = UIColor.blackColor()
            self.maskView?.alpha = 0.8
            self.view.addSubview(self.maskView!)
            
            
            //选择控件
            self.segCtrl = UISegmentedControl(items: ["全部","免费","限免","付费"])
            self.segCtrl?.frame = CGRectMake(50, 80, 280, 44)
            
            //文字
            self.segCtrl?.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: .Normal)
           
            //事件
            self.segCtrl?.addTarget(self, action: #selector(selectAction(_:)), forControlEvents: .ValueChanged)
           
            //显示上次选中的序号
            self.segCtrl!.selectedSegmentIndex = self.selectIndex
            self.view.addSubview(self.segCtrl!)

            
            self.chooseBtn?.setTitle("取消", forState: .Normal)
            
            
        }
        
        

    }
    
    
    func selectAction(segCtrl: UISegmentedControl) {
        //下载数据
        self.selectIndex = segCtrl.selectedSegmentIndex
        
        self.curPage = 1
        
        self.downloadData()
        
        //修改按钮文字
        let title = segCtrl.titleForSegmentAtIndex(self.selectIndex)
        self.chooseBtn?.setTitle(title, forState: .Normal)
        
        self.tbView?.contentOffset = CGPointZero
        
        //视图隐藏
        self.segCtrl?.removeFromSuperview()
        self.maskView?.removeFromSuperview()
        
    }
    
    
    
    func backAction(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    override func downloadData(){
        
        ProgressHUD.showOnView(self.view)
        
        var price = ""
        if (self.selectIndex == 0) {
            price = "all"
        }else if (self.selectIndex == 1){
            price = "free"
        }else if (self.selectIndex == 2){
            price = "pricedrop"
        }else if (self.selectIndex == 3){
            price = "paid"
        }
        
        let urlString = String(format: kCategoryUrl, self.categoryStr!,self.pageSize!,self.curPage,price)
        
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


extension CateListViewController {
    
    func downloader(downloader: MyDownloader, didFailWithError error: NSError) {
        print(error)
        
        ProgressHUD.hideAfterFailOnView(self.view)
    }
    
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
    
}


//MARK: UITableView代理
extension CateListViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellID = "homeCellId"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? HomeCell
        
        if (nil == cell) {
            cell = NSBundle.mainBundle().loadNibNamed("HomeCell", owner: nil, options: nil).last as? HomeCell
        }
        
        let model = self.dataArray[indexPath.row] as! HomeModel
        cell?.configModel(model, atIndex: indexPath.row)
        
        return cell!
        
    }
    
    
}





