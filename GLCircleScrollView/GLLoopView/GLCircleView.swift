//
//  CirCleView.swift
//  GLCircleScrollVeiw
//
//  Created by god、long on 15/7/3.
//  Copyright (c) 2015年 ___GL___. All rights reserved.
//

import UIKit
import Kingfisher


/// 图片类型
///
/// - local: 本地图片
/// - url: 远程图片
enum GLImageStringType {
    case local
    case url
}


/// 图片Model
class GLImageModel: NSObject {
    var name: String?
    var stringType: GLImageStringType?
    
    override init() {
        super.init()
    }
    
    convenience init(_ name: String, type: GLImageStringType) {
        self.init()
        self.name = name
        self.stringType = type
    }
}



typealias ClickCircleViewClosure = (_ currentIndex: Int) -> Void


@IBDesignable class GLCircleView: UIView, UIScrollViewDelegate {
    /*********************************** Property ****************************************/
    //MARK:- Public Property 供外界调用和更改

    /// 滑动的时间间隔
    @IBInspectable public var timeInterval: Double = 2.5 {
        didSet {
            if self.enableTimer {
                self.timer?.invalidate()
                self.timer = nil
                self.timer = Timer.scheduledTimer(timeInterval: self.timeInterval, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: true)
            }
        }
    }

    @IBInspectable public var enableTimer: Bool = true {
        didSet {
            if self.enableTimer {
                self.timer?.fireDate = Date.distantPast
            }else {
                self.timer?.fireDate = Date.distantFuture
            }
        }
    }
    
    /// 图片Model数组，供外界赋值更改
    public var imageModelArray: [GLImageModel]! {
        didSet {
            //监听图片数组的变化，如果有变化立即刷新轮转图中显示的图片
            self.setScrollViewOfImage()
            //如果数据源改变，则需要改变scrollView、分页指示器的数量
            self.contentScrollView.isScrollEnabled = !(imageModelArray.count <= 1)
            self.pageIndicator?.numberOfPages = self.imageModelArray.count
            self.setScrollViewOfImage()
        }
    }
    
    /// 点击图片的代理方法 当前点击图片的下标
    public var clickCircleViewClosure: ClickCircleViewClosure?
    
    
    //MARK: Private Property
    
    /// 当前显示的第几张图片
    private var indexOfCurrentImage: Int!  {
        // 监听显示的第几张图片，来更新分页指示器
        didSet {
            self.pageIndicator.currentPage = indexOfCurrentImage
        }
    }
    /// 滑动的ScrollView
    @IBOutlet weak private var contentScrollView: UIScrollView!

    /// 当前显示
    @IBOutlet weak private var currentImageView: UIImageView!
    /// 上一个
    @IBOutlet weak private var lastImageView: UIImageView!
    /// 下一个
    @IBOutlet weak private var nextImageView: UIImageView!
    
    /// 页数指示器
    @IBOutlet weak var pageIndicator: UIPageControl!
    
    /// 计时器
    private var timer: Timer?
    
    /// 加载View
    private var contentView: UIView!
    
    /*********************************** Init Methods ****************************************/
    //MARK:- Init Methods
    /// 代码初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        let bundle = Bundle(for: GLCircleView.self)
        let nib = UINib(nibName: String(describing: GLCircleView.self), bundle: bundle)
        self.contentView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        self.addSubview(contentView)
        self.contentView.frame = bounds
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // 默认显示第一张图片
        self.indexOfCurrentImage = 0
        self.imageModelArray = []
        self.setUpCircleView()
    }
    
    /// xib初始化
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let bundle = Bundle(for: GLCircleView.self)
        let nib = UINib(nibName: String(describing: GLCircleView.self), bundle: bundle)
        self.contentView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        self.addSubview(contentView)
        self.contentView.frame = bounds
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
        // 默认显示第一张图片
        self.indexOfCurrentImage = 0
        self.imageModelArray = []
        self.setUpCircleView()
    }
    
    
    /********************************** Privite Methods ***************************************/
    //MARK:- Privite Methods
    /// 配置CircleView
    fileprivate func setUpCircleView() {

        // 添加点击事件
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(self.imageTapAction(_:)))
        currentImageView.addGestureRecognizer(imageTap)
        
        self.setScrollViewOfImage()
        contentScrollView.setContentOffset(CGPoint(x: self.frame.size.width, y: 0), animated: false)
        
        // 设置分页指示器
        self.pageIndicator.numberOfPages = self.imageModelArray.count

        // 设置计时器
        if self.timer == nil && self.enableTimer {
            self.timer = Timer.scheduledTimer(timeInterval: self.timeInterval, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: true)
        }
    }
    
    /// 赋值图片
    fileprivate func setScrollViewOfImage() {
        if self.indexOfCurrentImage >= self.imageModelArray.count {
            return;
        }
        let currentImageModel = self.imageModelArray[self.indexOfCurrentImage]
        self.assignImageView(imageView: self.currentImageView, imageModel: currentImageModel)
        
        let nextImageModel = self.imageModelArray[self.getNextImageIndex(indexOfCurrentImage: self.indexOfCurrentImage)]
        self.assignImageView(imageView: self.nextImageView, imageModel: nextImageModel)
        
        let lastImageModel = self.imageModelArray[self.getLastImageIndex(indexOfCurrentImage: self.indexOfCurrentImage)]
        self.assignImageView(imageView: self.lastImageView, imageModel: lastImageModel)
    }
    
    /// 根据imageModel.stringType判断是本地还是远端，来执行不同的赋值语句给imageView赋值
    ///
    /// - Parameters:
    ///   - imageView: 要赋值的ImageView
    ///   - imageModel: 判断的ImageModel
    fileprivate func assignImageView(imageView: UIImageView, imageModel: GLImageModel) {
        switch imageModel.stringType! {
        case .local:
            imageView.image = UIImage(named: imageModel.name!)
        case GLImageStringType.url:
            imageView.kf.setImage(with: URL(string: imageModel.name!))
        }
    }
    
    /// 得到上一张图片的下标
    fileprivate func getLastImageIndex(indexOfCurrentImage index: Int) -> Int {
        let tempIndex = index - 1
        if tempIndex == -1 {
            return self.imageModelArray.count - 1
        }else{
            return tempIndex
        }
    }
    
    /// 得到下一张图片的下标
    fileprivate func getNextImageIndex(indexOfCurrentImage index: Int) -> Int {
        let tempIndex = index + 1
        return tempIndex < self.imageModelArray.count ? tempIndex : 0
    }
    
    /// 计时器触发方法
    @objc fileprivate func timerAction() {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "HH:mm:ss.SSS"
        print(formatter.string(from: Date()), "timeAction", terminator: "  ")
        
        contentScrollView.setContentOffset(CGPoint(x: self.frame.size.width*2, y: 0), animated: true)
    }
    
    /// 点击轮播图
    @objc fileprivate func imageTapAction(_ tap: UITapGestureRecognizer){
        self.clickCircleViewClosure?(self.indexOfCurrentImage)
    }
    
    /********************************** Public Methods  ***************************************/
    //MARK:- Public Methods
    

    
    
    /********************************** Delegate Methods ***************************************/
    //MARK:- Delegate Methods
    //MARK: UIScrollViewDelegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // 用户拖动时，把计时器停掉
        if self.enableTimer {
            self.timer?.fireDate = Date.distantFuture
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        //如果用户手动拖动到了一个整数页的位置就不会发生滑动了 所以需要判断手动调用滑动停止滑动方法
        if !decelerate {
            self.scrollViewDidEndDecelerating(scrollView)
        }
        // 用户拖动结束，打开计时器
        if self.enableTimer {
            self.timer?.fireDate = Date(timeIntervalSinceNow: 5.0)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let offset = scrollView.contentOffset.x
        if offset == 0 {
            self.indexOfCurrentImage = self.getLastImageIndex(indexOfCurrentImage: self.indexOfCurrentImage)
        }else if offset == self.frame.size.width * 2 {
            self.indexOfCurrentImage = self.getNextImageIndex(indexOfCurrentImage: self.indexOfCurrentImage)
        }
        // 重新布局图片
        self.setScrollViewOfImage()
        //布局后把contentOffset设为中间
        scrollView.setContentOffset(CGPoint(x: self.frame.size.width, y: 0), animated: false)
    }
    
    // 时间触发器 设置滑动时动画true，会触发的方法
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.scrollViewDidEndDecelerating(self.contentScrollView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 适配旋转，始终显示中间的ImageView
        self.contentScrollView.setContentOffset(CGPoint(x: self.frame.size.width, y: 0), animated: false)

    }
}











