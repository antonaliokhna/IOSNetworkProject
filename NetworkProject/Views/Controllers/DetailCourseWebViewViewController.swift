//
//  DetailCourseWebViewViewController.swift
//  NetworkProject
//
//  Created by Anton Aliokhna on 9/8/22.
//

import UIKit
import WebKit

class DetailCourseWebViewViewController: UIViewController, WKNavigationDelegate {
    var courseVideModel: CourseViewModelType!

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let courdeVideModel = courseVideModel else {
            showOkAlert(title: "Error", subtitle: "Url not found") {
                self.navigationController?.popViewController(animated: true)
            }
            return
        }
        navigationItem.title = courseVideModel.name
        webView.navigationDelegate = self
        webView.load(URLRequest(url: courdeVideModel.link))
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }

    private func showOkAlert(title: String, subtitle: String, actionOk: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
            actionOk()
        })
        present(alert, animated: true)
    }
}
