//
//  NetworkTask.swift
//  GeographicAtlas
//
//  Created by Amanzhan Zharkynuly on 13.05.2023.
//

import UIKit
import Alamofire

protocol NetworkTaskProtocol {
//    func getAllCountries(completion: @escaping (Result<CountriesListResponse, Error>) -> Void)
//    func getCountry(ccaTwo: String, completion: @escaping (Result<CountryResponse, Error>) -> Void)
}

struct NetworkRoutable: URLRequestConvertible {
    var baseURL: String = Constants.API.baseURL
    var path: String
    var method: HTTPMethod
    var parameters: Parameters?
    var encoding: ParameterEncoding
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL().appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return try encoding.encode(urlRequest, with: parameters)
    }
    
}

final class NetworkTask: NetworkTaskProtocol {
    
    // MARK: - Public Methods
    
    func getAllCountries(completion: @escaping (Result<[CountriesList], Error>) -> Void) {
        let allCountriesRoute = NetworkRoutable(path: "all", method: .get, encoding: URLEncoding.default)
        perform(allCountriesRoute, completion: completion)
    }
    
    func getCountry(ccaTwo: String, completion: @escaping (Result<[Country], Error>) -> Void) {
        let countryRoute = NetworkRoutable(path: "alpha/" + ccaTwo, method: .get, encoding: URLEncoding.default)
        perform(countryRoute, completion: completion)
    }
}

// MARK: - Private Methods

private extension NetworkTask {
    
    private func perform<T: Decodable>(_ apiRoute: NetworkRoutable, completion: @escaping (Result<T, Error>) -> Void) {
        let dataRequest = AF.request(apiRoute)
        dataRequest
            .validate(statusCode: 200..<300)
            .responseDecodable { (response: AFDataResponse<T>) in
                switch response.result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

}
