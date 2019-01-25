

### 样式展示

* 如果所传tag数组元素比较多,超过view后可以滚动

![image](https://github.com/adampei/ScrollTagsView/blob/master/normal2.gif)

### 当控件总宽度 < view 的宽度的时候,有两种布局方式

* 平铺样式,依然按照给定的margin进行布局`tagView.isConstrainPlain = true`

![image](https://github.com/adampei/ScrollTagsView/blob/master/plain.gif)

* 普通布局`tagView.isConstrainPlain = false`

![image](https://github.com/adampei/ScrollTagsView/blob/master/normal.gif)

### 如何使用

* 创建tagview

```objc
/// 创建view
let tagView = ScrollTagsView(frame: CGRect.init(x: 0, y: 100, width: UIScreen.main.bounds.size.width, height: 35))
view.addSubview(tagView)
/// 标题数组
let titleArray = ["我该使用", "什么", "方法", "implemented", "这", "可以", "支持一", "个长文本", "短文本", "等等都可以", "非常awesome"]
//        let titleArray = ["我该使用", "什么", "方法",]
/// 默认选中第几个
tagView.defaultSelect = 0
/// 设置字体大小
tagView.fontSize = UIFont.systemFont(ofSize: 13)
/// 左侧距离屏幕边 距离
tagView.marginLeft = 30
/// 非选中状态颜色
tagView.colorNormal = .black
/// 选中文字颜色
tagView.colorSelected = .red
/// 设置背景色
//        tagView.colorBackground = .blue
/// 线比字宽出多少
tagView.lineOutOfWordsWidth = 15
/// 如果控件较少 是否均分展示
tagView.isConstrainPlain = false
/// 底部滚动线条颜色
tagView.colorLine = .red
/// 是否展示线条
tagView.isHideLine = false
/// 线条高度
tagView.heightLine = 2
tagView.createView(titleArray)
/// 点击事件回调
tagView.tapCallback = {idx in
    print(idx)
}

```



