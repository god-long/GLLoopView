//
//  FirstVC.swift
//  GLCircleScrollVeiw
//
//  Created by god、long on 15/7/3.
//  Copyright (c) 2015年 ___GL___. All rights reserved.
//

import UIKit

class FirstVC: UIViewController, CirCleViewDelegate {

    
    var circleView: CirCleView!
    
    /********************************** System Methods *****************************************/
    //MARK:- System Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CirCle"
        self.automaticallyAdjustsScrollViewInsets = false
        let imageArray: [UIImage?] = [UIImage(named: "first.jpg"), UIImage(named: "second.jpg"), UIImage(named: "third.jpg")]

        self.circleView = CirCleView(frame: CGRect(x: 0, y: 64, width: self.view.frame.size.width, height: 200), imageArray: imageArray)
        circleView.backgroundColor = UIColor.orange
        circleView.delegate = self
        self.view.addSubview(circleView)
        
        let tempButton = UIButton(frame: CGRect(x: 0, y: 300, width: self.view.frame.size.width, height: 20))
        tempButton.backgroundColor = UIColor.red
        tempButton.setTitle("appendImage", for: UIControlState())
        tempButton.addTarget(self, action: #selector(FirstVC.setImage(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(tempButton)
    }

    
    /********************************** Privite Methods ***************************************/
    //MARK:- Privite Methods
    func setImage(_ sender: UIButton) {
//        circleView.imageArray = [UIImage(named: "first.jpg"), UIImage(named: "third.jpg")]
        circleView.urlImageArray = ["http://pic1.nipic.com/2008-09-08/200898163242920_2.jpg"]
    }
    
    
    
    
    /************************** Delegate Methods *************************************/
    //MARK:- Delegate Methods
    //MARK: CirCleViewDelegate Methods

    func clickCurrentImage(_ currentIndxe: Int) {
        print(currentIndxe, terminator: "");
    }
    

    
    
    /************************** End & ReceiveMemory Methods ******************************/
    //MARK:- End Methods

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
