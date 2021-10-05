//
//  APIService.swift
//  ios_task
//
//  Created by Belkhadir anas on 28/8/2021.
//
import Foundation
import Combine

protocol APIServiceProtocol {
    func getAllRecipe() -> AnyPublisher<CommonResult, Error>
}


class MarleySpoonAPIService: APIServiceProtocol {
    func getAllRecipe() -> AnyPublisher<CommonResult, Error> {
        let query = [URLQueryItem(name: "sys.contentType.sys.id", value: "recipe"),
        URLQueryItem(name: "access_token", value: apiKey)]
        let path = "entries"
        return request(path: path, query: query, method: .get)
    }

}
