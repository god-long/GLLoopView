# GLCircleScrollView
---

无限循环轮播图


### GLCircleScrollView 有以下主要功能：
---

   * 无限循环轮播

   * 图片点击代理

   * 可设置图片Url的数组（如果要赋url数组的话，最好自己改成sd加载图片的方式）

### 截图
---

![](https://github.com/god-long/GLCircleScrollView/raw/master/Circle.gif)

### 使用方法：
---

  下载后直接把CirCleView.swift这个文件引入项目中

* 简单代码例子

```swift
  var imageArray: [UIImage!] = [UIImage(named: "first.jpg"), UIImage(named: "second.jpg"), UIImage(named: "third.jpg")]
  self.circleView = CirCleView(frame: CGRectMake(0, 64, self.view.frame.size.width, 200), imageArray: imageArray)
  circleView.backgroundColor = UIColor.orangeColor()
  circleView.delegate = self
  self.view.addSubview(circleView)
```

### TODO
---

  *这个基本上是最简单的版本了，后续会添加一些其他的功能*
