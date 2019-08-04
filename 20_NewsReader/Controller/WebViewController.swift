//
//  WebViewController.swift
//  20_NewsReader
//
//  Created by Chrissy Satyananda on 04/08/19.
//  Copyright © 2019 Odjichrissy. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    
    var urlBerita: String?
    var judulBerita: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.load(URLRequest(url: URL(string: urlBerita!)!))
    }
    
    

}
