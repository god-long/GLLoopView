//
//  ShowCircleViewController.swift
//  GLCircleScrollView
//
//  Created by 许龙 on 2017/7/10.
//  Copyright © 2017年 loongod. All rights reserved.
//

import UIKit

let url1 = "http://4493bz.1985t.com/uploads/allimg/140820/4-140R0135233.jpg"
let url2 = "https://gss0.baidu.com/94o3dSag_xI4khGko9WTAnF6hhy/wenku/q%3D90%3Bw%3D500/sign=854f819faf86c9170e035e39f24a4dfa/9213b07eca8065381c52c1749fdda144ad348218.jpg"

class ShowCircleViewController: UIViewController {

    @IBOutlet weak var circleView: GLCircleView!
    
    /********************************** System Methods *****************************************/
    //MARK:- System Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Circle"
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        
        let imageArray: [GLImageModel] = [GLImageModel("first.jpg", type: .local), GLImageModel("second.jpg", type: .local), GLImageModel("third.jpg", type: .local)]
        
        self.circleView.imageModelArray = imageArray
        self.circleView.timeInterval = 5
        self.circleView.clickCircleViewClosure = { currentIndex in
            print(currentIndex, terminator: " ");
        }
    }
    
    
    /********************************** Privite Methods ***************************************/
    //MARK:- Privite Methods
    @IBAction func appendImageAction(_ sender: UIButton) {

        let urlImageModel = GLImageModel(self.circleView.imageModelArray.count % 2 == 0 ? url1 : url2, type: .url)
        self.circleView.imageModelArray.append(urlImageModel)
    }
    
    
    /************************** Delegate Methods *************************************/
    //MARK:- Delegate Methods

    
    
    
    
    /************************** End & ReceiveMemory Methods ******************************/
    //MARK:- End Methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

