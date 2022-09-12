//
//  HomeCollectionViewController.swift
//  NetworkProject
//
//  Created by Anton Aliokhna on 9/8/22.
//

import UIKit

class HomeCollectionViewController: UICollectionViewController {
    private let actions = ButtonAction.allCases

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Shoose action"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Settings",
            style: .plain,
            target: self,
            action: #selector(showPickerVC)
        )
    }

    private func validateShowOkAlert(data: Data?) {
        DispatchQueue.main.async {
            guard let data = data, let stringData = String(data: data, encoding: .utf8) else {
                self.showOkAlert(title: "Empty", message: "Nil")
                return
            }

            self.showOkAlert(title: "Suscess", message: stringData)
        }
    }

    private func showOkAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }

    private func showDownloadingAlert() {
        let alert = UIAlertController(title: "Downloading...", message: "0%", preferredStyle: .alert)
        let heightConstraint = NSLayoutConstraint(item: alert.view!,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: .none,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1,
                                                  constant: 170)
        alert.view.addConstraint(heightConstraint)
        let okAlertAction = UIAlertAction(title: "Resume", style: .default)
        alert.addAction(okAlertAction)
        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .destructive) { _ in
            DataProviderManager.shared.cancelDownloading()
        }
        alert.addAction(cancelAlertAction)

        present(alert, animated: true) {
            let activityIndicator = self.configurateActivityIndicatorView(by: alert.view.frame.size)
            alert.view.addSubview(activityIndicator)

            let progressView = self.configurateProgressView(by: alert.view.frame.size)
            alert.view.addSubview(progressView)

            DataProviderManager.shared.onProgress = { progress in
                progressView.progress = Float(progress)
                alert.message = "\(Int(progress * 100))%"
            }
            DataProviderManager.shared.fileLocation = { location in
                NotificationManager.sentNotificationBy(
                    title: "Downloading complete!",
                    body: "File path: \(location.absoluteString)"
                )
                alert.dismiss(animated: true)
            }
        }
    }

    private func configurateActivityIndicatorView(by subViewSize: CGSize) -> UIActivityIndicatorView {
        let activityIndicatorSize = CGSize(width: 50, height: 50)
        let activityIndicatorPoint = CGPoint(
            x: subViewSize.width / 2 - (activityIndicatorSize.width / 2),
            y: subViewSize.height / 2 - (activityIndicatorSize.height / 2)
        )

        let activityIndicatorView = UIActivityIndicatorView(
            frame: CGRect(origin: activityIndicatorPoint, size: activityIndicatorSize)
        )
        activityIndicatorView.style = .large
        activityIndicatorView.isHidden = false
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.startAnimating()

        return activityIndicatorView
    }

    private func configurateProgressView(by subViewSize: CGSize) -> UIProgressView {
        let progressViewSize = CGSize(width: subViewSize.width, height: 2)
        let progressViewPoint = CGPoint(x: 0, y: subViewSize.height - 44)

        let progressView = UIProgressView(frame: CGRect(origin: progressViewPoint, size: progressViewSize))
        progressView.progress = 0

        return progressView
    }

    @objc private func showPickerVC() {
        performSegue(withIdentifier: "goToPickerVC", sender: self)
    }
}

//MARK: - UICollectionViewController

extension HomeCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
                as? HomeCollectionViewCell else { return UICollectionViewCell() }
        cell.actionLabel.text = actions[indexPath.row].rawValue
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch actions[indexPath.row] {
        case .downloadImage:
            performSegue(withIdentifier: "showImageVC", sender: nil)
        case .get:
            NetworkSession.network.getQuery(from: StringUrl.posts.rawValue) { [weak self] data in
                    self?.validateShowOkAlert(data: data)
            }
        case .post:
            let data = ["One": "I am one", "Two": "I am two"]
            NetworkSession.network.postQuery(from: StringUrl.posts.rawValue, data: data) { [weak self] data in
                self?.validateShowOkAlert(data: data)
        }
        case .courses:
            performSegue(withIdentifier: "showCoursesTableVC", sender: nil)
        case .uploadImage:
            guard let image = UIImage(named: "1") else { return }
            NetworkSession.network.uploadImage(from: StringUrl.uploadImage.rawValue, image: image) { [weak self] data in
                self?.validateShowOkAlert(data: data)
            }
        case .backroundDownloadData:
            if !DataProviderManager.shared.isProcessing {
                DataProviderManager.shared.startDownloading(from: StringUrl.bigFile.rawValue)
            }
            showDownloadingAlert()
        }
    }
}
