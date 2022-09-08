//
//  URLSessionNetworkManager.swift
//  NetworkProject
//
//  Created by Anton Aliokhna on 9/8/22.
//

import Foundation
import UIKit

class URLSessionNetworkManager: NetworkManagerType {

    func getQuery(from stringUrl: String, completion: @escaping (Data?) -> ()) {
        guard let url = URL(string: stringUrl) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil, let data = data else {
                completion(nil)
                return
            }
          completion(data)
        }
        .resume()
    }

    func postQuery(from stringUrl: String, data: [String: String], completion: @escaping (Data?) -> ()) {
        guard let url = URL(string: stringUrl), let jsonData = try? JSONEncoder().encode(data) else {
            completion(nil)
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData

        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard error == nil, let data = data else {
                completion(nil)
                return
            }
          completion(data)
        }
        .resume()
    }

    func fetchImage(from stringUrl: String, completion: @escaping (_ image: UIImage?) -> () ) {
        guard let url = URL(string: stringUrl) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil, let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }
        .resume()
    }

    func fetchCourses(from stringUrl: String, completion: @escaping (_ courses: [Course]) -> ()) {
        guard let url = URL(string: stringUrl) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else { return }
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let courses = try jsonDecoder.decode([Course].self, from: data)
                completion(courses)
            } catch {
                print(error.localizedDescription)
            }
        }
        .resume()
    }

    func uploadImage(from stringUrl: String, image: UIImage, completion: @escaping (Data?) -> ()) {
        guard let url = URL(string: stringUrl) else {
            completion(nil)
            return
        }

        let httpHeaders = ["Authorization" : "Client-ID 1bd22b9ce396a4c"]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = httpHeaders
        request.httpBody = image.pngData()!

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            completion(data)
        }
        .resume()
    }

}
