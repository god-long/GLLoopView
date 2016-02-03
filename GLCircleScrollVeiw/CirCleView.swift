//
//  CirCleView.swift
//  GLCircleScrollVeiw
//
//  Created by god、long on 15/7/3.
//  Copyright (c) 2015年 ___GL___. All rights reserved.
//

import UIKit

let TimeInterval = 2.5          //全局的时间间隔

class CirCleView: UIView, UIScrollViewDelegate {
    /*********************************** Property ****************************************/
    //MARK:- Property

    var contentScrollView: UIScrollView!
    
    var imageArray: [UIImage!]! {
        //监听图片数组的变化，如果有变化立即刷新轮转图中显示的图片
        willSet(newValue) {
            self.imageArray = newValue
        }
        /**
        *  如果数据源改变，则需要改变scrollView、分页指示器的数量
        */
        didSet {
            contentScrollView.scrollEnabled = !(imageArray.count == 1)
            self.pageIndicator.frame = CGRectMake(self.frame.size.width - 20 * CGFloat(imageArray.count), self.frame.size.height - 30, 20 * CGFloat(imageArray.count), 20)
            self.pageIndicator?.numberOfPages = self.imageArray.count
            self.setScrollViewOfImage()
        }
    }
    
    var urlImageArray: [String]? {
        willSet(newValue) {
            self.urlImageArray = newValue
        }
        
        didSet {
            //这里用了强制拆包，所以不要把urlImageArray设为nil
            for urlStr in self.urlImageArray! {
                let urlImage = NSURL(string: urlStr)
                if urlImage == nil { break }
                let dataImage = NSData(contentsOfURL: urlImage!)
                if dataImage == nil { break }
                let tempImage = UIImage(data: dataImage!)
                if tempImage == nil { break }
                imageArray.append(tempImage)
            }
        }
    }

    var delegate: CirCleViewDelegate?
    
    var indexOfCurrentImage: Int!  {                // 当前显示的第几张图片
        //监听显示的第几张图片，来更新分页指示器
        didSet {
            self.pageIndicator.currentPage = indexOfCurrentImage
        }
    }
    
    var currentImageView:   UIImageView!
    var lastImageView:      UIImageView!
    var nextImageView:      UIImageView!
    
    var pageIndicator:      UIPageControl!          //页数指示器
    
    var timer:              NSTimer?                //计时器
    
    
    /*********************************** Begin ****************************************/
    //MARK:- Begin
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, imageArray: [UIImage!]?) {
        self.init(frame: frame)
        self.imageArray = imageArray

        // 默认显示第一张图片
        self.indexOfCurrentImage = 0
        self.setUpCircleView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /********************************** Privite Methods ***************************************/
    //MARK:- Privite Methods
    private func setUpCircleView() {
        self.contentScrollView = UIScrollView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
        contentScrollView.contentSize = CGSizeMake(self.frame.size.width * 3, 0)
        contentScrollView.delegate = self
        contentScrollView.bounces = false
        contentScrollView.pagingEnabled = true
        contentScrollView.backgroundColor = UIColor.greenColor()
        contentScrollView.showsHorizontalScrollIndicator = false
        contentScrollView.scrollEnabled = !(imageArray.count == 1)
        self.addSubview(contentScrollView)
        
        self.currentImageView = UIImageView()
        currentImageView.frame = CGRectMake(self.frame.size.width, 0, self.frame.size.width, 200)
        currentImageView.userInteractionEnabled = true
        currentImageView.contentMode = UIViewContentMode.ScaleAspectFill
        currentImageView.clipsToBounds = true
        contentScrollView.addSubview(currentImageView)
        
        //添加点击事件
        let imageTap = UITapGestureRecognizer(target: self, action: Selector("imageTapAction:"))
        currentImageView.addGestureRecognizer(imageTap)
        
        self.lastImageView = UIImageView()
        lastImageView.frame = CGRectMake(0, 0, self.frame.size.width, 200)
        lastImageView.contentMode = UIViewContentMode.ScaleAspectFill
        lastImageView.clipsToBounds = true
        contentScrollView.addSubview(lastImageView)
        
        self.nextImageView = UIImageView()
        nextImageView.frame = CGRectMake(self.frame.size.width * 2, 0, self.frame.size.width, 200)
        nextImageView.contentMode = UIViewContentMode.ScaleAspectFill
        nextImageView.clipsToBounds = true
        contentScrollView.addSubview(nextImageView)
        
        self.setScrollViewOfImage()
        contentScrollView.setContentOffset(CGPointMake(self.frame.size.width, 0), animated: false)
        
        //设置分页指示器
        self.pageIndicator = UIPageControl(frame: CGRectMake(self.frame.size.width - 20 * CGFloat(imageArray.count), self.frame.size.height - 30, 20 * CGFloat(imageArray.count), 20))
        pageIndicator.hidesForSinglePage = true
        pageIndicator.numberOfPages = imageArray.count
        pageIndicator.backgroundColor = UIColor.clearColor()
        self.addSubview(pageIndicator)
        
        //设置计时器
        self.timer = NSTimer.scheduledTimerWithTimeInterval(TimeInterval, target: self, selector: "timerAction", userInfo: nil, repeats: true)
    }
    
    //MARK: 设置图片
    private func setScrollViewOfImage(){
        self.currentImageView.image = self.imageArray[self.indexOfCurrentImage]
        self.nextImageView.image = self.imageArray[self.getNextImageIndex(indexOfCurrentImage: self.indexOfCurrentImage)]
        self.lastImageView.image = self.imageArray[self.getLastImageIndex(indexOfCurrentImage: self.indexOfCurrentImage)]
    }
    
    // 得到上一张图片的下标
    private func getLastImageIndex(indexOfCurrentImage index: Int) -> Int{
        let tempIndex = index - 1
        if tempIndex == -1 {
            return self.imageArray.count - 1
        }else{
            return tempIndex
        }
    }
    
    // 得到下一张图片的下标
    private func getNextImageIndex(indexOfCurrentImage index: Int) -> Int
    {
        let tempIndex = index + 1
        return tempIndex < self.imageArray.count ? tempIndex : 0
    }
    
    //事件触发方法
    func timerAction() {
        print("timer", terminator: "")
        contentScrollView.setContentOffset(CGPointMake(self.frame.size.width*2, 0), animated: true)
    }

    
    /********************************** Public Methods  ***************************************/
    //MARK:- Public Methods
    func imageTapAction(tap: UITapGestureRecognizer){
        self.delegate?.clickCurrentImage!(indexOfCurrentImage)
    }
    
    
    /********************************** Delegate Methods ***************************************/
    //MARK:- Delegate Methods
    //MARK: UIScrollViewDelegate
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        timer?.invalidate()
        timer = nil
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        //如果用户手动拖动到了一个整数页的位置就不会发生滑动了 所以需要判断手动调用滑动停止滑动方法
        if !decelerate {
            self.scrollViewDidEndDecelerating(scrollView)
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {

        let offset = scrollView.contentOffset.x
        if offset == 0 {
            self.indexOfCurrentImage = self.getLastImageIndex(indexOfCurrentImage: self.indexOfCurrentImage)
        }else if offset == self.frame.size.width * 2 {
            self.indexOfCurrentImage = self.getNextImageIndex(indexOfCurrentImage: self.indexOfCurrentImage)
        }
        // 重新布局图片
        self.setScrollViewOfImage()
        //布局后把contentOffset设为中间
        scrollView.setContentOffset(CGPointMake(self.frame.size.width, 0), animated: false)
        
        //重置计时器
        if timer == nil {
            self.timer = NSTimer.scheduledTimerWithTimeInterval(TimeInterval, target: self, selector: "timerAction", userInfo: nil, repeats: true)
        }
    }
    
    //时间触发器 设置滑动时动画true，会触发的方法
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        print("animator", terminator: "")
        self.scrollViewDidEndDecelerating(contentScrollView)
    }

}

/********************************** Protocol Methods ***************************************/
//MARK:- Protocol Methods 


@objc protocol CirCleViewDelegate {
    /**
    *  点击图片的代理方法
    *  
    *  @para  currentIndxe 当前点击图片的下标
    */
    optional func clickCurrentImage(currentIndxe: Int)
}










