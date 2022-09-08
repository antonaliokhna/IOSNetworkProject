//
//  AlamofireNetworkManager.swift
//  NetworkProject
//
//  Created by Anton Aliokhna on 9/8/22.
//

import Foundation
import Alamofire

class AlamofireNetworkManager: NetworkManagerType {

    func getQuery(from stringUrl: String, completion: @escaping (Data?) -> ()) {
        guard let url = URL(string: stringUrl) else {
            completion(nil)
            return
        }

        AF.request(url).validate().response { response in
            switch response.result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                completion(nil)
                print(error.localizedDescription)
            }
        }
    }

    func postQuery(from stringUrl: String, data: [String: String], completion: @escaping (Data?) -> ()) {
        guard let url = URL(string: stringUrl) else {
            completion(nil)
            return
        }

        AF.request(url, method: .post, parameters: data, encoder: .json).validate().response { response in
            print(response)
            switch response.result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                completion(nil)
                print(error.localizedDescription)
            }
        }
    }

    func fetchImage(from stringUrl: String, completion: @escaping (_ image: UIImage?) -> () ) {
        guard let url = URL(string: stringUrl) else {
            completion(nil)
            return
        }

        AF.request(url).validate().responseData { responseData in
            guard let data = responseData.data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }
    }

    func fetchCourses(from stringUrl: String, completion: @escaping (_ courses: [Course]) -> ()) {
        guard let url = URL(string: stringUrl) else { return }

        let jsonDecored: JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }()

        AF.request(url).validate().responseDecodable(of: [Course].self, decoder: jsonDecored) { response in
            switch response.result {
            case .success(let courses):
                completion(courses)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func uploadImage(from stringUrl: String, image: UIImage, completion: @escaping (Data?) -> ()) {
        guard let url = URL(string: stringUrl), let imagePngData = image.pngData() else {
            completion(nil)
            return
        }

        let httpHeaders = ["Authorization" : "Client-ID 1bd22b9ce396a4c"]
        AF.upload(imagePngData, to: url, headers: HTTPHeaders(httpHeaders)).validate().responseData { responseData in
            switch responseData.result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                completion(nil)
                print(error.localizedDescription)
            }
        }
    }

}
