//
//  File.swift
//  
//
//  Created by Ari Supriatna on 13/10/21.
//

import Foundation
import Combine
import Alamofire

/// The News Remote Data Source Protocol
public protocol NKNewsRemoteDataSourceProtocol: AnyObject {
  /// The function for search news
  /// - Parameter query: The query from user input
  /// - Returns: The list of ``NKNews``
  func searchNews(by query: String) -> AnyPublisher<[NKNews], Error>
  
  /// The function for fetch news by category
  /// - Parameter category: The category of news ``NKNewsCategory``
  /// - Returns: The list of ``NKNews``
  func fetchNewsByCategory(by category: NKNewsCategory) -> AnyPublisher<[NKNews], Error>
  
  /// The function for fetch news top headline
  /// - Parameter country: The country from ``NKCountryCode``
  /// - Returns: The list of ``NKNews``
  func fetchNewsTopHeadline(by country: NKCountryCode) -> AnyPublisher<[NKNews], Error>
}

/// The News Remote Data Source
public final class NKNewsRemoteDataSource: NSObject {
  private override init() { }
  
  /// The shared instance of ``NKNewsRemoteDataSource``
  public static let sharedInstance = NKNewsRemoteDataSource()
}

extension NKNewsRemoteDataSource: NKNewsRemoteDataSourceProtocol {
  public func searchNews(by query: String) -> AnyPublisher<[NKNews], Error> {
    return Future<[NKNews], Error> { completion in
      let url = URL(string: "\(NKNewsEndpoint.Get.search(query: query).url)\(NewsKit.apiKey)")!
      
      AF.request(url)
        .validate()
        .responseDecodable(of: NKNewsResponse.self) { response in
          switch response.result {
          case .success(let result):
            completion(.success(result.articles))
          case .failure:
            completion(.failure(NKNewsError.invalidSerialization))
          }
        }
    }.eraseToAnyPublisher()
  }
  
  public func fetchNewsByCategory(by category: NKNewsCategory) -> AnyPublisher<[NKNews], Error> {
    return Future<[NKNews], Error> { completion in
      let url = URL(string: "\(NKNewsEndpoint.Get.category(category: category).url)\(NewsKit.apiKey)")!
      
      AF.request(url)
        .validate()
        .responseDecodable(of: NKNewsResponse.self) { response in
          switch response.result {
          case .success(let result):
            completion(.success(result.articles))
          case .failure:
            completion(.failure(NKNewsError.invalidSerialization))
          }
        }
    }.eraseToAnyPublisher()
  }
  
  public func fetchNewsTopHeadline(by country: NKCountryCode) -> AnyPublisher<[NKNews], Error> {
    return Future<[NKNews], Error> { completion in
      let url = URL(string: "\(NKNewsEndpoint.Get.topHeadline(country: country).url)\(NewsKit.apiKey)")!
      
      AF.request(url)
        .validate()
        .responseDecodable(of: NKNewsResponse.self) { response in
          switch response.result {
          case .success(let result):
            completion(.success(result.articles))
          case .failure:
            completion(.failure(NKNewsError.invalidSerialization))
          }
        }
    }.eraseToAnyPublisher()
  }
}
