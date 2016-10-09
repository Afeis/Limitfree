//
//  HomeCell.swift
//  IpaDown_SWift
//
//  Created by gaokunpeng on 16/8/8.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    
    @IBOutlet weak var appImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var rateLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var sizeLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    
    @IBOutlet weak var statusLabel: UILabel!
    
    
    func configModel(model: HomeModel, atIndex index: Int) {
        
        //图片
        let url = NSURL(string: model.app_icon!)
        self.appImageView.kf_setImageWithURL(url, placeholderImage: UIImage(named: "placeholder"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        
        //名字
        self.nameLabel.text = "\(index+1).\(model.post_title!)"
        
        //评级
        if model.app_apple_rated != nil {
            let rate = Float(model.app_apple_rated!)
            self.rateLabel.text = "评分:\(rate!)星"
        }else{
            self.rateLabel.text = "评分:未知"
        }
        
        
        //类别
        self.categoryLabel.text = "类别:\(model.app_category!)"
        
        //大小
        self.sizeLabel.text = model.app_size!
        
        
        //描述
        self.descLabel.text = model.app_desc!
        
        
        //状态
        
        if (Int(model.app_pricedrop!)! == 1) {
            //降价或限免
            self.statusLabel.backgroundColor = UIColor(red: 50.0/255.0, green: 120.0/255.0, blue: 200.0/255.0, alpha: 1.0)
            self.statusLabel.layer.cornerRadius = 8
            self.statusLabel.clipsToBounds = true
            self.statusLabel.textColor = UIColor.whiteColor()
            
            if (Float(model.app_price!)! > 0) {
                self.statusLabel.text = "降价中"
            }else{
                self.statusLabel.text = "限免中"
            }
            
        }else if (Int(model.app_pricedrop!)! == 0){
            //原价
            self.statusLabel.backgroundColor = UIColor(red: 50.0/255.0, green: 70.0/255.0, blue: 120.0/255.0, alpha: 1.0)
            self.statusLabel.layer.cornerRadius = 8
            self.statusLabel.clipsToBounds = true
            self.statusLabel.textColor = UIColor.whiteColor()
            
            if (Float(model.app_price!)! > 0) {
                self.statusLabel.text = "\(model.app_price!)元"
            }else{
                self.statusLabel.text = "免费"
            }
            
        }
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
