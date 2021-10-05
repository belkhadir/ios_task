//
//  NetworkHelper.swift
//  ios_task
//
//  Created by Belkhadir anas on 28/8/2021.
//

import Foundation
import Combine

enum HTTPMethod: String{
    case post = "POST"
    case get = "GET"
}

private let host = "cdn.contentful.com"

func request<T: Codable>(path: String,
                        query: [URLQueryItem],
                        method: HTTPMethod) -> AnyPublisher<T, Error> {
    
    var compenents = URLComponents()
    compenents.scheme = "https"
    compenents.host = host
    
    compenents.path = "/spaces/\(spaceID)/environments/master/" + path
    
    compenents.queryItems = query
    
    let url = compenents.url!
    return URLSession.shared
        .dataTaskPublisher(for: url)
        .map(\.data)
        .decode(type: T.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
}
