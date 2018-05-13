//
//  HRStepperView.swift
//  WaterDispenser
//
//  Created by HenryGao on 2018/3/23.
//  Copyright © 2018年 HenryGao. All rights reserved.
//

import UIKit

//@objc
//protocol HRStepperViewDelegate {
//    @objc func change(value num : Int)
//}

@IBDesignable
class HRStepperView: UIView {
    
    
    // open
    @IBInspectable
    var title : String = "描述标题显示" {
        didSet{
            hrTitle.text = title
        }
    }
    @IBInspectable
    var minSize : Int = Int.min   // 最小值
    @IBInspectable
    var maxSize : Int = Int.max   // 最大值
    @IBInspectable
    var addSize : Int = 0         // 递减的区间
    @IBInspectable
    var defaultSize : Int = 0{    // 默认值
        didSet{
            hrTextF.text = "\(defaultSize)"
            tempNum = defaultSize
        }
    }
    typealias StepperBack = (_ num : Int)->Void
    var back : StepperBack?
    
    
    
    
    // 获取 数值
    var num : Int { return self.tempNum }
    
    
    
    
    
    // private
    @IBOutlet fileprivate var contentView: UIView!
    @IBOutlet fileprivate weak var hrTitle: UILabel!
    @IBOutlet fileprivate weak var hrTextF: UITextField!
    @IBOutlet fileprivate weak var hrDownBtn: UIButton!
    @IBOutlet fileprivate weak var hrUpBtn: UIButton!
    @IBOutlet fileprivate weak var errorInfoHeight: NSLayoutConstraint!
    @IBOutlet fileprivate weak var errorInfo: UILabel!
    fileprivate var tempNum : Int = 0 {
        willSet{
            hrTextF.text = "\(newValue)"
        }
    }
    
    
    
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        //        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        createView()
    }
    
    
    
    fileprivate func createView() {
        
        let nib = UINib(nibName: "HRStepperView", bundle: nil)
        contentView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        contentView.frame = bounds
        addSubview(contentView)
        
    }
    
    
    
    
    
    
    
    
    // MARK: - HenryGao add 事件
    @IBAction func btn(_ sender : UIButton){
        
        let tag = sender.tag
        
        if tag == 1111 {        // down
            if tempNum <= minSize {
                sleepStr(2, text: "\(title)不可小于\(minSize)")
                return
            }
            tempNum -= addSize
        }else if tag == 2222 {  // up
            
            if tempNum >= maxSize {
                sleepStr(2, text: "\(title)不可大于\(maxSize)")
                return
            }
            tempNum += addSize
        }
        
        back?(tempNum)
        
        
    }
    @IBAction func changeAction(_ sender: UITextField) {    // 值更改
        var num = Int(sender.text ?? "0") ?? 0
        if num >= maxSize {
            num = maxSize
        }else if num <= minSize {
            num = minSize
        }
        defaultSize = num //Int(sender.text ?? "\(defaultSize)") ?? defaultSize
        back?(num)
    }
    
    
    
    
    
    
    
    
    
    // MARK: - HenryGao add 睡眠 2秒
    fileprivate func sleepStr(_ time : Int , text : String) {
        
        UIView.animate(withDuration: 0.25, animations: {
            self.errorInfo.layoutIfNeeded()
        }) { (res) in
            self.errorInfo.text = text
            self.errorInfoHeight.constant = 15
        }
        
        
        
        DispatchQueue.global().async {
            sleep(UInt32(time))
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.25, animations: {
                    self.errorInfo.layoutIfNeeded()
                }) { (res) in
                    self.errorInfoHeight.constant = 0
                }
            }
            
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
