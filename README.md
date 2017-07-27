# GLLoopView


 ![](https://img.shields.io/badge/Swift-3.0-orange.svg) [![license](https://img.shields.io/github/license/god-long/GLLoopView.svg)](https://github.com/god-long/GLLoopView/blob/master/LICENSE) [![GitHub stars](https://img.shields.io/github/stars/god-long/GLLoopView.svg?style=social&label=Star)](https://github.com/god-long/GLLoopView) [![GitHub forks](https://img.shields.io/github/forks/god-long/GLLoopView.svg?style=social&label=Fork)]()


## 描述：

   **swift版的无限循环轮播图，可自定义时间间隔，设置本地、远端图片或混设，目前配合[Kingfisher](https://github.com/onevcat/Kingfisher)一起使用（url图片赋值ImageView和缓存）。**


## 功能：

   * 无限循环轮播
   
   * 图片点击闭包
   
   * 本地、远端图片混设
   
   * 支持**code**、**xib**、**storyboard**调用
   
   * 支持旋转
   
   * 支持**iPhone**、**iPad**


## 运行展示图：

### iPhone:

![iPhone](https://github.com/god-long/GLCircleScrollView/raw/master/GLLoopView-iPhone.gif) 

### iPad:
![iPad](https://github.com/god-long/GLCircleScrollView/raw/master/GLLoopView-iPad.gif) 

   
   
   
   
## 安装：

下载后直接把**GLLoopView**文件夹（里面有CircleView.swift和CircleView.xib2个文件）拉进项目中。

*（因有xib文件，支持cocoapods在storyboard和xib中使用时，会报编译错误，对运行无影响，所以暂缓支持cocoapods）*

pod添加kingfisher（或者其它方法）


## 使用方法：


### xib || storyboard:

```
        let imageArray: [GLImageModel] = [GLImageModel("first.jpg", type: .local), GLImageModel("second.jpg", type: .local), GLImageModel("third.jpg", type: .local)]
        
        self.circleView.imageModelArray = imageArray
        self.circleView.timeInterval = 5
        self.circleView.clickCircleViewClosure = { currentIndex in
            print(currentIndex, terminator: " ");
        }

```


### code: (能用可视化就用可视化，不要再代码创建了)

```
        let imageArray: [GLImageModel] = [GLImageModel("first.jpg", type: .local), GLImageModel("second.jpg", type: .local), GLImageModel("third.jpg", type: .local)]
        
        self.circleView = GLCircleView(frame: CGRect(x: 0, y: 64, width: self.view.frame.size.width, height: 200))
        self.circleView.imageModelArray = imageArray
        self.circleView.timeInterval = 5
        self.circleView.clickCircleViewClosure = { currentIndex in
            print(currentIndex, terminator: " ");
        }
        self.view.addSubview(circleView)

```
   
### 添加：
  
```
        let urlImageModel = GLImageModel(self.circleView.imageModelArray.count % 2 == 0 ? url1 : url2, type: .url)
        self.circleView.imageModelArray.append(urlImageModel)

```


## 下步计划：

  * 支持pod
  
  * 开放更多功能

  
 **如有意见，欢迎issue**

  

