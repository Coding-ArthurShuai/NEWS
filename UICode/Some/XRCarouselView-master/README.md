# XRCarouselView
The easiest way to use image circulate

超简单好用的图片轮播框架，两个imageView实现

使用过程中发现bug请先下载最新版，若bug依旧存在，请及时反馈，谢谢

实现原理[请看这里](http://www.jianshu.com/p/ef03ec7f23b2)

______

#XRCarouselView的优点
1.文件少，代码简洁

2.同时支持本地图片及网络图片

3.自带图片下载与缓存，不依赖任何第三方库

4.性能好，占用内存少，轮播流畅

5.自定义分页控件及图片描述

#如何集成XRCarouselView
###导入
######方式一：手动导入
将XRCarouselView文件夹中的所有文件添加到项目中
######方式二：cocoapods导入
pod 'XRCarouselView'

###创建
######方式一：代码创建
1.导入主头文件 XRCarouselView.h

2.创建XRCarouselView，设置各属性

3.将XRCarouselView添加到要展示到view上面
######方式二：直接添加到xib\sb
1.添加一个view到xib\sb上

2.设置view的class为XRCarouselView

3.拖线到.m文件中，设置各属性



#XRCarouselView的常用属性方法

1.imageArray：要轮播的图片数组，可传本地图片或网络图片路径

2.describeArray：图片描述的字符串数组，应与图片顺序对应

3.time：设置每页的停留时间

4.void(^imageClickBlock)(NSInteger index)：图片被点击后要执行的代码

5.clearDiskCache：清除沙盒中的图片缓存

#效果演示
![](http://ww1.sinaimg.cn/large/b68232a1gw1f2g66tc8vkg20ad05b7tf.gif)



######最后给大家推荐一个滚动视图隐藏导航栏的框架，轻松集成

[https://github.com/HelloYeah/HYNavBarHidden](https://github.com/HelloYeah/HYNavBarHidden)

![1.gif](http://upload-images.jianshu.io/upload_images/1338042-b49f8c85cef44460.gif?imageMogr2/auto-orient/strip)
    