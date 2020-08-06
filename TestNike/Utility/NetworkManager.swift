//
//  NetworkManager.swift
//  TestApp
//
//  Created by Manjul Shrestha on 8/3/20.
//  Copyright © 2020 Manjul Shrestha. All rights reserved.
//

import Foundation
import UIKit

enum AcceptType: String{
    case XML = "application/xml"
    case JSON = "application/json"
}


class NetworkManager{
    static let shared = NetworkManager()
    
    public func fetchRSSFeed(completion: @escaping (Result<FeedDataModel, Error>) -> Void){
        guard let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/100/explicit.json") else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(AcceptType.JSON.rawValue, forHTTPHeaderField: "accept")
        
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            let feedResponse = try? JSONDecoder().decode(FeedDataModel.self, from: data)
            completion(.success(feedResponse!))
        }.resume()
    }
    
    public func downloadImage(fromString urlString: String,completion: @escaping ((UIImage) -> Void)){
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else { return }
            if let image = UIImage(data: data){
                completion(image)
                return
            }
        }
        
    }
    



    
}
