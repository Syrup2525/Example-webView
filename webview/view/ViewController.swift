//
//  ViewController.swift
//  webview
//
//  Created by 김경환 on 2022/11/01.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tfUrl: CommonTextField!
    @IBOutlet var parameterTextView: CommonTextView!
    
    private let WEB_VIEW_SEGUE = "WebViewSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = UserDefaults.standard.string(forKey: "url")
        let header = UserDefaults.standard.string(forKey: "header")

        tfUrl.text = url ?? ""
        parameterTextView.text = header ?? ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let webViewController = segue.destination as? WebViewController {
            webViewController.url = tfUrl.text
            webViewController.parameter = parameterTextView.text
            
            UserDefaults.standard.set(tfUrl.text, forKey: "url")
            UserDefaults.standard.set(parameterTextView.text, forKey: "header")
        }
    }
    
    @IBAction func onClickGo(_ sender: UIButton) {
        self.performSegue(withIdentifier: self.WEB_VIEW_SEGUE, sender: nil)
    }
}

