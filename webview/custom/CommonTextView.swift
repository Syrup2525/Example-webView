//
//  CommonTextView.swift
//  webview
//
//  Created by 김경환 on 2022/11/01.
//

import UIKit

@IBDesignable
class CommonTextView: UIView {
    @IBOutlet var textView: UITextView!
    
    private var _focusborderColor: UIColor?
    private var _unFocusborderColor: UIColor?
    
    @IBInspectable
    var text: String {
        get {
            return textView.text ?? ""
        }
        
        set {
            textView.text = newValue
        }
    }
    
    /// 모서리 둥글게
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return textView.layer.cornerRadius
        }
        
        set {
            self.textView.clipsToBounds = true
            self.textView.layer.cornerRadius = newValue
        }
    }
    
    /// 테두리 굵기
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return textView.layer.borderWidth
        }
        
        set {
            self.textView.layer.borderWidth = newValue
        }
    }
    
    /// 테두리 색상 (포커스)
    @IBInspectable
    var focusborderColor: UIColor? {
        get {
            return _focusborderColor
        }
        
        set {
            self._focusborderColor = newValue
        }
    }
    
    /// 테두리 색상 (포커스 해제)
    @IBInspectable
    var unFocusborderColor: UIColor? {
        get {
            return _unFocusborderColor
        }
        
        set {
            self._unFocusborderColor = newValue
            self.textView.layer.borderColor = newValue?.cgColor
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadXib()
    }
    
    private func loadXib() {
        let bundle = Bundle(for: CommonTextView.self)
        let identifier = String(describing: CommonTextView.self)
        let view = bundle.loadNibNamed(identifier, owner: self, options: nil)?.first as! UIView
        
        view.frame = bounds
        addSubview(view)
        
        initLayout()
    }
    
    private func initLayout() {
        self.textView.delegate = self
        
        addDoneButtonOnKeyboard()
    }
    
    private func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title:  NSLocalizedString("완료", comment: ""), style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.textView.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(){
        self.textView.resignFirstResponder()
    }
}

extension CommonTextView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.layer.borderColor = _focusborderColor?.cgColor
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.layer.borderColor = _unFocusborderColor?.cgColor
    }
}
