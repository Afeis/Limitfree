//
//  BaseViewController.swift
//  IpaDown_SWift
//
//  Created by gaokunpeng on 16/8/8.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class BaseViewController: MyNavViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    //列表
    lazy var dataArray = NSMutableArray()
    
    var tbView: UITableView?
    
    
    //下拉刷新
    var curPage: Int = 1
    var pageSize: Int?
    
    
    
    //下载列表数据
    func downloadData(){}

    
    func refreshHeader(){}

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        //表格
        self.createTableView()
        
        //下载数据
        self.curPage = 1
        self.pageSize = 20
        
        self.downloadData()
    }
    
    
    func createTableView(){
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.tbView = UITableView(frame: CGRectMake(0, 0, 375, 667-64-49), style: .Plain)

        self.tbView!.delegate = self
        self.tbView!.dataSource = self
        self.view.addSubview(self.tbView!)
    }
    
    
    //上拉加载更多
    func addFooter(){
        
        if self.tbView?.footerView == nil {
            self.tbView?.footerView = XWRefreshAutoNormalFooter(target: self, action: #selector(loadNextPage))
        }
        
    }
    //下拉刷新
    func addHeader(){
        if self.tbView?.headerView == nil {
            self.tbView?.headerView = XWRefreshNormalHeader(target: self, action: #selector(loadFirstPage))
        }
        
    }
    
    
    //下载第一页数据
    func loadFirstPage(){
        
        self.curPage = 1
        
        self.downloadData()
        
        //下拉刷新需要做的其他事情
        self.refreshHeader()
        
    }
    
    //加载下一页数据
    func loadNextPage(){
        
        self.curPage += 1
        
        self.downloadData()
        
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

//MARK: UITableView代理
extension BaseViewController {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("子类必须实现tableView:numberOfRowsInSection")
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("子类必须实现tableView:cellForRowAtIndexPath")
        return UITableViewCell()
        
    }
    
}


