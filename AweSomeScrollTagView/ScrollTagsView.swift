//
//  ScrollTagsView.swift
//  AweSomeScrollTagView
//
//  Created by 裴波波 on 2019/1/23.
//  Copyright © 2019 裴波波. All rights reserved.
//

import UIKit

class ScrollTagsView: UIView {
    
    /// scrollView
    private var scroView: UIScrollView!
    /// 总长度 label + margin间隙
    private var lengthTotal: CGFloat!
    var titleArray: Array<String>! {
        didSet {
            createView(titleArray)
        }
    }

    override init(frame: CGRect) {
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
    
    func createView(_ titlesArray: Array<String>) {
        
        scroView = UIScrollView(frame: bounds)
        scroView.showsHorizontalScrollIndicator = false
        scroView.backgroundColor = .orange
        addSubview(scroView)
        
        let marginLeft = CGFloat(18.5)
        /// 全部margin宽度
        let totalLength = marginLeft * CGFloat(2) * CGFloat(titlesArray.count)
        /// 总的label的宽度
        var lblWidth: CGFloat! = 0
        /// 布局uilabel用
        var leftMargin: CGFloat = marginLeft
        /// 每个label宽度数组
        var arrLblWidths: Array<CGFloat> = []
        
        for i in 0..<titlesArray.count {
            
            let singleSize: CGSize = textSize(text: titlesArray[i], font: UIFont.systemFont(ofSize: 15), maxSize: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
            arrLblWidths.append(singleSize.width)
            lblWidth = lblWidth + singleSize.width
            
            let lblTitle = UILabel()
            lblTitle.text = titlesArray[i]
            lblTitle.isUserInteractionEnabled = true
            lblTitle.textColor = .black
            scroView.addSubview(lblTitle)
            lblTitle.font = UIFont.systemFont(ofSize: 15)
            lblTitle.frame = CGRect.init(x: leftMargin, y: 0.5 * (bounds.size.height - singleSize.height), width: singleSize.width, height: singleSize.height)
            leftMargin = leftMargin + singleSize.width + 2 * marginLeft
            /// 绑定tag
            lblTitle.tag = i
            
            /// 添加手势
            let tap = UITapGestureRecognizer(target: self, action: #selector(clickLbl(sender:)))
            lblTitle.addGestureRecognizer(tap)
        }
        
        /// lable宽度 + margin间隙
        lengthTotal = lblWidth! + totalLength
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
    
    @objc func clickLbl(sender: UITapGestureRecognizer) {
        
        let lbl: UILabel = sender.view as! UILabel
//        print("tag = \(lbl.tag)")
//        print("x = \(lbl.frame.maxX)")
//        print("x = \(lbl.frame.midX)")
//        print("x = \(lbl.frame.minX)")
//        print("contentfooset = \(scroView.contentOffset.x)")
        
        let middleX = lbl.frame.midX
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

