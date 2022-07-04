//
//  SchoolAPIService.swift
//  ios-mvvm-template
//
//  Created by Thuong Nguyen on 7/3/22.
//

import Foundation

struct EndPoint {
    struct APIDetails {
        static let APIScheme = "https"
        static let APIHost = "data.cityofnewyork.us"
        static let APIPath = "/resource/"
        static let schoolsPath = "s3k6-pzi2.json"
    }
}

struct SchoolAPIService : SchoolAPIServiceProtocol {
    private let sessionManager: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
    }()
    
    func fetchSchools(completion: @escaping (Bool, [School], Error?) -> Void) {
        guard let url = createURLFromPath(EndPoint.APIDetails.schoolsPath, parameters: ["$limit": "15","$offset":"0","$order":"school_name"]) else {
            completion(false, [], apiError(errorId: 401, description: "Invalid URL", errorKind: apiError.ErrorKind.invalidUrl))
            return
        }
        
        let request = URLRequest(url: url)
        sessionManager.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(false, [], apiError(errorId: 500, description: "Server error", errorKind: apiError.ErrorKind.serverError))
                return
            }
            
            guard let data = data else {
                completion(true,[], nil)
                return
            }
            
            let response = try? JSONDecoder().decode([School].self, from: data)
            if let response = response, !response.isEmpty {
                completion(true, response, nil)
            } else {
                completion(true, [], nil)
            }
        }.resume()
    }
}

extension SchoolAPIService {
    private func createURLFromPath(_ path: String?, parameters: [String: Any]?) -> URL? {
        var components = URLComponents()
        components.scheme = EndPoint.APIDetails.APIScheme
        components.host   = EndPoint.APIDetails.APIHost
        components.path   = EndPoint.APIDetails.APIPath
        if let paramPath = path {
            components.path = EndPoint.APIDetails.APIPath + "\(paramPath)"
        }
        if !(parameters?.isEmpty ?? false) {
            components.queryItems = [URLQueryItem]()
            for (key, value) in parameters! {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                components.queryItems!.append(queryItem)
            }
        }

        return components.url
    }
}

struct apiError: Error {
    enum ErrorKind {
        case invalidUrl
        case serverError
        case noDataFound
    }
    let errorId: Int
    let description: String?
    let errorKind: ErrorKind
}
