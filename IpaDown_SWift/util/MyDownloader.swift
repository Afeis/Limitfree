//
//  MyDownloader.swift
//  IpaDown_SWift
//
//  Created by gaokunpeng on 16/8/8.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

protocol MyDownloaderDelegate: NSObjectProtocol {
    
    //下载成功
    func downloader(downloader: MyDownloader, didFinishWithData data: NSData)
    
    //下载失败
    func downloader(downloader: MyDownloader, didFailWithError error: NSError)
    
}


class MyDownloader: NSObject {
    
    //代理属性
    var delegate: MyDownloaderDelegate?
    
    //类型
    var type: Int?
    
    
    
    
    //下载的方法
    func downloadWithUrlString(urlString: String) {
        
       
            
        //1.NSURL对象
        let url = NSURL(string: urlString)
        //2.NSURLRequest
        let request = NSURLRequest(URL: url!)
        //3.NSURLSession
        let session = NSURLSession.sharedSession()
        //4.NSURLSessionDataTask
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
            if let err = error {
                //失败
                self.delegate?.downloader(self, didFailWithError: err)
                
            }else{
                let resp = response as! NSHTTPURLResponse
                if resp.statusCode == 200 {
                    //下载成功
                    self.delegate?.downloader(self, didFinishWithData: data!)
                    
                    
                }else{
                    //下载失败
                    
                    let myError = NSError(domain: urlString, code: resp.statusCode, userInfo: ["msg": "下载失败"])
                    
                    self.delegate?.downloader(self, didFailWithError: myError)
                    
                }
            }
            
        }
        //5.开始下载
        task.resume()
        
    }

    
}
