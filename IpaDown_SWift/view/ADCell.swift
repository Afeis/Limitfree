//
//  ADCell.swift
//  IpaDown_SWift
//
//  Created by gaokunpeng on 16/8/8.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class ADCell: UITableViewCell ,UIScrollViewDelegate{

    
    @IBOutlet weak var myScrollView: UIScrollView!
    
    @IBOutlet weak var myPageCtrl: UIPageControl!
    
    
    var dataArray: NSArray? {
        
        didSet {
            
            for i in 0..<(self.dataArray?.count)! {
                //模型对象
                let model = self.dataArray![i] as! ADModel
                
                let frame = CGRectMake(375*CGFloat(i), 0, 375, 160)
                
                let imageView = MyUtil.createImageView(frame, imageName: nil)
                let url = NSURL(string: model.pic!)
                imageView.kf_setImageWithURL(url, placeholderImage: UIImage(named: "placeholder"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
    
                self.myScrollView.addSubview(imageView)

            }
            
            
            self.myScrollView.delegate = self;
            self.myScrollView.pagingEnabled = true
            self.myScrollView.bounces = false
            self.myScrollView.contentSize = CGSizeMake(375*CGFloat(self.dataArray!.count), 160);
            
            
            //分页
            self.myPageCtrl.numberOfPages = self.dataArray!.count
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

//MARK: UIScrollView代理
extension ADCell{
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let index = Int(scrollView.contentOffset.x/scrollView.bounds.size.width)
        self.myPageCtrl.currentPage = index
    }
    
    
    
    
    
}


