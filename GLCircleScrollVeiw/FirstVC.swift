//
//  FirstVC.swift
//  GLCircleScrollVeiw
//
//  Created by god、long on 15/7/3.
//  Copyright (c) 2015年 ___GL___. All rights reserved.
//

import UIKit

class FirstVC: UIViewController {

    
    var circleView: CirCleView!
    
    /********************************** System Methods *****************************************/
    //MARK:- System Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CirCle"
        self.automaticallyAdjustsScrollViewInsets = false
        var imageArray: [UIImage!] = [UIImage(named: "first.jpg"), UIImage(named: "second.jpg"), UIImage(named: "third.jpg")]

        var imageArray2: [UIImage!] = [UIImage(named: "first.jpg")]

        self.circleView = CirCleView(frame: CGRectMake(0, 64, self.view.frame.size.width, 200), imageArray: imageArray)
        circleView.backgroundColor = UIColor.orangeColor()
        self.view.addSubview(circleView)
        
        var tempButton = UIButton(frame: CGRectMake(0, 300, self.view.frame.size.width, 20))
        tempButton.backgroundColor = UIColor.redColor()
        tempButton.setTitle("appendImage", forState: UIControlState.Normal)
        tempButton.addTarget(self, action: Selector("setImage:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(tempButton)
        

        
    }

    
    /********************************** Privite Methods ***************************************/
    //MARK:- Privite Methods
    func setImage(sender: UIButton) {
//        circleView.imageArray = [UIImage(named: "first.jpg"), UIImage(named: "third.jpg")]
        circleView.urlImageArray = ["http://img.xiaba.cvimage.cn/4d1337aac0ca1f517e320500.jpg"]
    }
    
    
    /********************************** Public Methods  ***************************************/
    //MARK:- Public Methods
    
    
    
    /********************************** Delegate Methods ***************************************/
    //MARK:- Delegate Methods
    
    

    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
