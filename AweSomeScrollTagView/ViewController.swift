//
//  ViewController.swift
//  AweSomeScrollTagView
//
//  Created by 裴波波 on 2019/1/23.
//  Copyright © 2019 裴波波. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let line = UIView(frame: CGRect.init(x: UIScreen.main.bounds.size.width*0.5, y: 0, width: 1, height: 300))
        line.backgroundColor = .red
        view.addSubview(line)
        
        let tagView = ScrollTagsView(frame: CGRect.init(x: 0, y: 100, width: UIScreen.main.bounds.size.width, height: 35))
        view.addSubview(tagView)
        let titleArray = ["我该使用", "什么", "方法", "implemented", "这", "可以", "支持一", "个长文本", "短文本", "等等都可以", "非常awesome"]
        /// 默认选中第几个
        tagView.defaultSelect = 0
        /// 设置字体大小
        tagView.fontSize = UIFont.systemFont(ofSize: 18)
        /// 左侧距离屏幕边 距离
        tagView.marginLeft = 30
        /// 非选中状态颜色
        tagView.colorNormal = .black
        /// 选中文字颜色
        tagView.colorSelected = .red
        /// 设置背景色
//        tagView.colorBackground = .blue
        /// 线比字宽出多少
//        tagView.lineOutOfWordsWidth = 15
        /// 底部滚动线条颜色
        tagView.colorLine = .red
        tagView.createView(titleArray)
        /// 点击事件回调
        tagView.tapCallback = {idx in
            print(idx)
        }
    }


}

