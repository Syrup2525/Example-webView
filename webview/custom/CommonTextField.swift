//
//  CommonTextField.swift
//  webview
//
//  Created by 김경환 on 2022/11/01.
//

import UIKit

@IBDesignable
class CommonTextField: UIView {
    @IBOutlet private var textField: UITextField!
    
    public var shouldReturnClosure: (() -> ())?
    
    private var _focusborderColor: UIColor?
    private var _unFocusborderColor: UIColor?
    
    @IBInspectable
    var placeholder: String {
        get {
            return textField.placeholder ?? ""
        }
        
        set {
            textField.placeholder = newValue
        }
    }
    
    @IBInspectable
    var text: String {
        get {
            return textField.text ?? ""
        }
        
        set {
            textField.text = newValue
        }
    }
    
    /// 모서리 둥글게
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return textField.layer.cornerRadius
        }
        
        set {
            self.textField.clipsToBounds = true
            self.textField.layer.cornerRadius = newValue
        }
    }
    
    /// 테두리 굵기
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return textField.layer.borderWidth
        }
        
        set {
            self.textField.layer.borderWidth = newValue
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
            self.textField.layer.borderColor = newValue?.cgColor
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
        let bundle = Bundle(for: CommonTextField.self)
        let identifier = String(describing: CommonTextField.self)
        let view = bundle.loadNibNamed(identifier, owner: self, options: nil)?.first as! UIView
        
        view.frame = bounds
        addSubview(view)
        
        initLayout()
    }
    
    private func initLayout() {
        self.textField.delegate = self
        
        addDoneButtonOnKeyboard()
    }
    
    private func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title:  NSLocalizedString("완료", comment: ""), style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.textField.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.textField.resignFirstResponder()
    }
}

extension CommonTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = _focusborderColor?.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = _unFocusborderColor?.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        shouldReturnClosure?()
        
        return true
    }
}
