//
//  ImageViewController.swift
//  NetworkProject
//
//  Created by Anton Aliokhna on 9/8/22.
//

import UIKit

class ImageViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Image"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NetworkSession.network.fetchImage(
            from: StringUrl.jpgImage.rawValue) { image in
                DispatchQueue.main.async {
                    guard let image = image else {
                        self.showOkAlert(title: "Error", subtitle: "Invalid downloading image from url!")
                        return
                    }
                    self.imageView.image = image
                    self.activityIndicator.stopAnimating()
                }
            }
    }

    private func showOkAlert(title: String, subtitle: String) {
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}
