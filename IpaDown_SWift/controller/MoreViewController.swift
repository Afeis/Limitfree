//
//  MoreViewController.swift
//  IpaDown_SWift
//
//  Created by gaokunpeng on 16/8/8.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

public let kImageArray = "imageArray"
public let kTitleArray = "titleArray"
public let kSubtileArray = "subtitleArray"

class MoreViewController: MyNavViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tbView: UITableView?
    
    //数据源
    lazy var dataArray = NSMutableArray()
    
    //组标题
    var titleArray: NSArray?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //数据源
        self.titleArray = ["更多栏目","客户端设置","关于客户端","关于i派党","我们的iOS移动客户端","我们的电脑客户端"];
        
        self.createDataArray()
        
        //表格
        self.createTableView()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.addNavLabelTitle("更多")
        
    }
    
    
    //数据源
    func createDataArray(){
       
        
        //更多栏目
        var dict1 = Dictionary<String,AnyObject>()
        
        dict1[kImageArray] = ["c-top","c-zt","c-guide","c-jc"]
        dict1[kTitleArray] = ["排行标题","应用专题","精品导购","苹果学院"]
        dict1[kSubtileArray] = ["Appstroe各国实时排行榜","归类推荐精品软件游戏","精品应用程序导购指南","iPhone小技巧一网打尽"]
        self.dataArray.addObject(dict1)
        
        //客户端设置
        var dict2 = Dictionary<String,AnyObject>()
    
        dict2[kTitleArray] = ["我收藏的Apps","清空本地缓存","开启或关闭推送"]
        dict2[kSubtileArray] = ["","一键清空","设置"]
        self.dataArray.addObject(dict2)
        
        //关于客户端
        var dict3 = Dictionary<String,AnyObject>()
        
        dict3[kTitleArray] = ["软件名称","软件作者","意见反馈","技术支持","去AppStore给我们评价"]
        dict3[kSubtileArray] = ["精品显示免费","花太香齐","ieliwb@gmail.com","www.ipadown.com",""]
        self.dataArray.addObject(dict3)
       
        
        //关于i派党
        var dict4 = Dictionary<String,AnyObject>()
        
        dict4[kTitleArray] = ["关于ipai党","团队联系方式","App玩家交流QQ群"]
        self.dataArray.addObject(dict4)
        
        
        //我们的iOS移动客户端
        var dict5 = Dictionary<String,AnyObject>()
        
        dict5[kTitleArray] = ["《精品限时免费》 for iPad","《苹果i新闻》for iPhone"]
        self.dataArray.addObject(dict5)
        
        
        //我们的电脑客户端
        var dict6 = Dictionary<String,AnyObject>()
        
        dict6[kTitleArray] = ["i派党Mac客户端","ipai党AIR客户端"]
        self.dataArray.addObject(dict6)

    }
    
   
    
    //表格
    func createTableView(){
        
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        
        self.tbView = UITableView(frame: CGRectMake(0, 0, 375, 667-64-49), style: .Grouped)
        self.tbView!.delegate = self
        self.tbView!.dataSource = self
        self.view.addSubview(self.tbView!)
        
        
        let headView = MyUtil.createImageView(CGRectMake(0, 0, 375, 80), imageName: "logo_empty")
        self.tbView?.tableHeaderView = headView
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
extension MoreViewController {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.dataArray.count
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let dict = self.dataArray[section] as! Dictionary<String,AnyObject>
        
        let titleArray = dict[kTitleArray] as! Array<String>
        return titleArray.count
        
        
    }
    
   
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "cellId"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId)
        
        var style: UITableViewCellStyle = .Subtitle
        
        if (indexPath.section == 1 || indexPath.section == 2) {
            style = .Value1
        }
        
        
        if (nil == cell) {
            cell = UITableViewCell(style: style, reuseIdentifier: cellId)
        }
        
        
        let dict = self.dataArray[indexPath.section] as! Dictionary<String,AnyObject>
        //标题
        let titleArray = dict[kTitleArray] as! Array<String>
        cell?.textLabel?.text = titleArray[indexPath.row]
        
        
        //图片
        if dict.keys.contains(kImageArray) {
            
            let imageArray = dict[kImageArray] as! Array<String>
            
            let imageName = imageArray[indexPath.row]
            cell?.imageView?.image = UIImage(named: imageName)
            
        }else{
            cell?.imageView?.image = nil
        }
        
        
        
        //副标题
        if dict.keys.contains(kSubtileArray) {
            
            let subtitleArray = dict[kSubtileArray] as! Array<String>
            
            cell!.detailTextLabel!.text = subtitleArray[indexPath.row]
            
        }else{
            cell!.detailTextLabel!.text = nil
        }
        
       
        
        cell!.accessoryType = .DisclosureIndicator
        
        
        return cell!
        
    }
    


    
}




