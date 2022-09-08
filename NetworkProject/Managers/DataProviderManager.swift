//
//  DataProviderManager.swift
//  NetworkProject
//
//  Created by Anton Aliokhna on 9/8/22.
//

import Foundation
import UIKit

class DataProviderManager: NSObject {
    static var shared = DataProviderManager()
    private var sessionDownloadTask: URLSessionDownloadTask!
    private lazy var bgSession: URLSession = {
        let sessionConfig = URLSessionConfiguration.background(withIdentifier: "backroundSession")
        sessionConfig.sessionSendsLaunchEvents = true
        return URLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
    }()

    var fileLocation: ((URL) -> ())?
    var onProgress: ((Double) -> ())?
    var isProcessing = false

    func startDownloading(from stringUrl: String) {
        guard let url = URL(string: stringUrl) else { return }
        isProcessing = true
        sessionDownloadTask = bgSession.downloadTask(with: url)
        sessionDownloadTask.earliestBeginDate = Date().addingTimeInterval(1)
        sessionDownloadTask.countOfBytesClientExpectsToSend = 512
        sessionDownloadTask.countOfBytesClientExpectsToReceive = 100 * 1024 * 1024
        sessionDownloadTask.resume()
    }

    func cancelDownloading() {
        sessionDownloadTask.cancel()
        fileLocation = nil
        onProgress = nil
        isProcessing = false
    }
}

//MARK: - URLSessionDownloadDelegate

extension DataProviderManager: URLSessionDownloadDelegate {
    func urlSession(
        _ session: URLSession,
        downloadTask: URLSessionDownloadTask,
        didFinishDownloadingTo location: URL)
    {
        self.isProcessing = false
        DispatchQueue.main.async {
            self.fileLocation?(location)
        }
    }

    func urlSession(
        _ session: URLSession,
        downloadTask: URLSessionDownloadTask,
        didWriteData bytesWritten: Int64,
        totalBytesWritten: Int64,
        totalBytesExpectedToWrite: Int64)
    {
        guard totalBytesExpectedToWrite != NSURLSessionTransferSizeUnknown else { return }
        let progress = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
        DispatchQueue.main.async {
            self.onProgress?(progress)
        }
    }
}

//MARK: - URLSessionDelegate

extension DataProviderManager: URLSessionDelegate {
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        DispatchQueue.main.async {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                  let completionHandler = appDelegate.backroundSessionCompletionHandler else { return }
            appDelegate.backroundSessionCompletionHandler = nil
            completionHandler()
        }
    }
}
