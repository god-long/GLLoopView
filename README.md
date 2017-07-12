# GLCircleView


#### 描述：

   **swift版的无限循环轮播图，可自定义时间间隔，设置本地、远端图片或混设，目前配合[Kingfisher](https://github.com/onevcat/Kingfisher)一起使用（url图片赋值ImageView和缓存）。**


#### 功能：

   * 无限循环轮播
   
   * 图片点击代理
   
   * 本地、远端图片混设
   
   * 支持code、xib、storyboard调用
   
   * 支持旋转


#### 运行展示图：

![运行展示](https://github.com/god-long/GLCircleScrollView/raw/master/Circle.gif) 

   
#### 使用方法：

下载后直接把CircleView.swift这个文件拉进项目中即可。

pod添加kingfisher

**xib || storyboard:**

```
        let imageArray: [GLImageModel] = [GLImageModel("first.jpg", type: .local), GLImageModel("second.jpg", type: .local), GLImageModel("third.jpg", type: .local)]
        
        self.circleView.imageModelArray = imageArray
        self.circleView.timeInterval = 5
        self.circleView.clickCircleViewClosure = { currentIndex in
            print(currentIndex, terminator: " ");
        }

```


**code: (能用可视化就用可视化，不要再代码创建了)**

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
   
**添加：**
  
```
        let urlImageModel = GLImageModel(self.circleView.imageModelArray.count % 2 == 0 ? url1 : url2, type: .url)
        self.circleView.imageModelArray.append(urlImageModel)

```


#### 下步计划：

  * 支持pod
  
  * 开放更多功能

  
 **如有意见，欢迎issue**

  

