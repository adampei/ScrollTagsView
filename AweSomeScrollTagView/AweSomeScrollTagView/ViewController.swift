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
        tagView.createView(titleArray)
    }


}

