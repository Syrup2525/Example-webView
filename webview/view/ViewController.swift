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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let webViewController = segue.destination as? WebViewController {
            webViewController.url = tfUrl.text
            webViewController.parameter = parameterTextView.text
        }
    }
    
    @IBAction func onClickGo(_ sender: UIButton) {
        self.performSegue(withIdentifier: self.WEB_VIEW_SEGUE, sender: nil)
    }
}

