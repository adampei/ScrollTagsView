//
//  ScrollTagsView.swift
//  AweSomeScrollTagView
//
//  Created by 裴波波 on 2019/1/23.
//  Copyright © 2019 裴波波. All rights reserved.
//

import UIKit

// MARK: 按钮高亮不显示背景色的按钮
class NoneHightedButton: UIButton {
    
    override var isHighlighted: Bool {
        set {
        }
        get {
            return false
        }
    }
}

public class ScrollTagsView: UIView {
    
    public typealias ClickCallabck = (_ idx: Int) -> Void
    
    /// 默认选中角标
    public var defaultSelect: Int = 0
    /// 选中字体颜色
    public var colorSelected: UIColor = .black
    /// textcolor of normal
    public var colorNormal: UIColor = .black
    /// 底部线条颜色
    public var colorLine: UIColor = .red
    /// 点击回调
    public var tapCallback:  ClickCallabck!
    /// marginleft
    public var marginLeft: CGFloat = 18.5
    /// font
    public var fontSize: UIFont = UIFont.systemFont(ofSize: 13)
    /// 背景色 默认白色
    public var colorBackground: UIColor = .white
    /// 线比字宽多少
    public var lineOutOfWordsWidth: CGFloat = 0
    /// 线条高度
    public var heightLine: CGFloat = 1
    /// 是否展示线条
    public var isHideLine: Bool = true
    
    /// 线条
    private var line: UIView!
    /// 当前选中的button
    private var currentSelectedBtn: NoneHightedButton!
    /// scrollView
    private var scroView: UIScrollView!
    /// 总长度 label + margin间隙
    private var lengthTotal: CGFloat!
    var titleArray: Array<String>! {
        didSet {
            createView(titleArray)
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: UI
extension ScrollTagsView {
    
    /// 计算宽度
    func textSize(text : String , font : UIFont , maxSize : CGSize) -> CGSize{
        return text.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : font], context: nil).size
    }
    
    public func createView(_ titlesArray: Array<String>) {
        
        scroView = UIScrollView(frame: bounds)
        scroView.showsHorizontalScrollIndicator = false
        scroView.backgroundColor = colorBackground
        addSubview(scroView)
        
        /// 全部margin宽度
        let totalLength = marginLeft * CGFloat(2) * CGFloat(titlesArray.count)
        /// 总的label的宽度
        var muTotalWidth: CGFloat! = 0
        /// 布局uilabel用
        var leftMargin: CGFloat = marginLeft
        /// 每个label宽度数组
        var arrMuWidths: Array<CGFloat> = []
        
        line = UIView(frame: CGRect.init(x: 0, y: scroView.bounds.size.height - 1, width: 0, height: heightLine))
        
        line.backgroundColor = colorLine
        line.isHidden = isHideLine
        scroView.addSubview(line)
        
        for i in 0..<titlesArray.count {
            
            let singleSize: CGSize = textSize(text: titlesArray[i], font: fontSize, maxSize: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
            arrMuWidths.append(singleSize.width)
            muTotalWidth = muTotalWidth + singleSize.width
            
            let btnTitle = NoneHightedButton()
            btnTitle.setTitle(titlesArray[i], for: .normal)
            btnTitle.setTitleColor(colorSelected, for: .selected)
            btnTitle.setTitleColor(colorNormal, for: .normal)
            scroView.addSubview(btnTitle)
            btnTitle.titleLabel?.font = fontSize
            btnTitle.frame = CGRect.init(x: leftMargin, y: 0.5 * (bounds.size.height - singleSize.height), width: singleSize.width, height: singleSize.height)
            leftMargin = leftMargin + singleSize.width + 2 * marginLeft
            /// 绑定tag
            btnTitle.tag = i
            btnTitle.addTarget(self, action: #selector(clickTag(sender:)), for: .touchUpInside)
            
            if i == defaultSelect {
                currentSelectedBtn = btnTitle
                btnTitle.isSelected = true
                line.frame = CGRect.init(x: btnTitle.frame.origin.x - 0.5 * lineOutOfWordsWidth, y: scroView.bounds.size.height - self.heightLine, width: btnTitle.bounds.size.width + lineOutOfWordsWidth, height: heightLine)
                line.isHidden = isHideLine
            } else {
                btnTitle.isSelected = false
            }
        }
        
        /// lable宽度 + margin间隙
        lengthTotal = muTotalWidth! + totalLength
        /// scollVIew的宽度
        let scrolWidth = bounds.size.width
        /// 判断是否可滚动
        if lengthTotal > scrolWidth {
            scroView.isScrollEnabled = true
            scroView.contentSize = CGSize.init(width: lengthTotal, height: 0)
        } else {
            scroView.isScrollEnabled = false
        }
    }
}

// MARK: events
extension ScrollTagsView {
    
    @objc func clickTag(sender: NoneHightedButton) {
        
        /// 点击回调
        if let callback = tapCallback {
            callback(sender.tag)
        }
        
        //        let lbl: UILabel = sender.view as! UILabel
        //        print("tag = \(lbl.tag)")
        //        print("x = \(lbl.frame.maxX)")
        //        print("x = \(lbl.frame.midX)")
        //        print("x = \(lbl.frame.minX)")
        //        print("contentfooset = \(scroView.contentOffset.x)")
        
        if sender.tag == defaultSelect {
            /// 点击同一个
        } else {
            
            /// 点击不同btn
            UIView.animate(withDuration: 0.3) {
                self.line.frame = CGRect.init(x: sender.frame.origin.x - 0.5 * self.lineOutOfWordsWidth, y: self.scroView.bounds.size.height - self.heightLine, width: sender.bounds.size.width + self.lineOutOfWordsWidth, height: self.heightLine)
            }
            
            currentSelectedBtn.isSelected = false
            sender.isSelected = true
            currentSelectedBtn = sender
            defaultSelect = sender.tag
        }
        
        let middleX = sender.frame.midX
        /// 实际偏移量
        // let realOffset = scroView.contentOffset.x
        let midScrollView = scroView.bounds.size.width * 0.5
        /// 需要偏移量
        let needOffset = middleX - midScrollView
        /// 如果偏移量 > contentsize.width了则不进行偏移
        if needOffset >= (lengthTotal - midScrollView * 2) {
            scroView.setContentOffset(CGPoint.init(x: lengthTotal - midScrollView * 2, y: 0), animated: true)
            return
        } else if middleX <= midScrollView {
            scroView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
            return
        }
        /// 对比是否可以偏移
        if middleX > midScrollView {
            /// 可以偏移 计算偏移
            scroView.setContentOffset(CGPoint.init(x: needOffset, y: 0), animated: true)
        }
    }
    
}

