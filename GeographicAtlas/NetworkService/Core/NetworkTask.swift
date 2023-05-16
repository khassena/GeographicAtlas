//
//  NetworkTask.swift
//  GeographicAtlas
//
//  Created by Amanzhan Zharkynuly on 13.05.2023.
//

import UIKit
import Alamofire

protocol NetworkTaskProtocol {
    func getAllCountries(completion: @escaping (Result<[CountriesList], Error>) -> Void)
    func getCountry(ccaTwo: String, completion: @escaping (Result<[Country], Error>) -> Void)
    func getImage(from url: URL?, completion: @escaping (Result<UIImage, Error>) -> Void)
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
    
    // MARK: - Private Properties
    
    private let imageCache = NSCache<AnyObject, AnyObject>()
    
    // MARK: - Public Methods
    
    func getAllCountries(completion: @escaping (Result<[CountriesList], Error>) -> Void) {
        let allCountriesRoute = NetworkRoutable(path: "all", method: .get, encoding: URLEncoding.default)
        perform(allCountriesRoute, completion: completion)
    }
    
    func getCountry(ccaTwo: String, completion: @escaping (Result<[Country], Error>) -> Void) {
        let countryRoute = NetworkRoutable(path: "alpha/" + ccaTwo, method: .get, encoding: URLEncoding.default)
        perform(countryRoute, completion: completion)
    }
    
    func getImage(from url: URL?, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = url else { return }
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            completion(.success(imageFromCache))
            return
        }
        fetchImage(from: url, completion: completion)
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
    
    private func fetchImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    completion(.failure(NSError(domain: "Invalid Image Data", code: 0, userInfo: nil)))
                    return
                }
                self.imageCache.setObject(image, forKey: url as AnyObject)
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
