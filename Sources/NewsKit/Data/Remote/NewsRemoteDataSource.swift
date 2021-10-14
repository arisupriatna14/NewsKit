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
  /// - Returns: The list of ``News``
  func searchNews(by query: String) -> AnyPublisher<[News], Error>
  
  /// The function for fetch news by category
  /// - Parameter category: The category of news ``NewsCategory``
  /// - Returns: The list of ``News``
  func fetchNewsByCategory(by category: NewsCategory) -> AnyPublisher<[News], Error>
  
  /// The function for fetch news top headline
  /// - Parameter country: The country from ``CountryCode``
  /// - Returns: The list of ``News``
  func fetchNewsTopHeadline(by country: CountryCode) -> AnyPublisher<[News], Error>
}

/// The News Remote Data Source
public final class NKNewsRemoteDataSource: NSObject {
  private override init() { }
  
  /// The shared instance of ``NKNewsRemoteDataSource``
  public static let sharedInstance = NKNewsRemoteDataSource()
}

extension NKNewsRemoteDataSource: NKNewsRemoteDataSourceProtocol {
  public func searchNews(by query: String) -> AnyPublisher<[News], Error> {
    return Future<[News], Error> { completion in
      let url = URL(string: "\(NewsEndpoint.Get.search(query: query).url)\(NewsKit.apiKey)")!
      
      AF.request(url)
        .validate()
        .responseDecodable(of: NewsResponse.self) { response in
          switch response.result {
          case .success(let result):
            completion(.success(result.articles))
          case .failure:
            completion(.failure(NewsError.invalidSerialization))
          }
        }
    }.eraseToAnyPublisher()
  }
  
  public func fetchNewsByCategory(by category: NewsCategory) -> AnyPublisher<[News], Error> {
    return Future<[News], Error> { completion in
      let url = URL(string: "\(NewsEndpoint.Get.category(category: category).url)\(NewsKit.apiKey)")!
      
      AF.request(url)
        .validate()
        .responseDecodable(of: NewsResponse.self) { response in
          switch response.result {
          case .success(let result):
            completion(.success(result.articles))
          case .failure:
            completion(.failure(NewsError.invalidSerialization))
          }
        }
    }.eraseToAnyPublisher()
  }
  
  public func fetchNewsTopHeadline(by country: CountryCode) -> AnyPublisher<[News], Error> {
    return Future<[News], Error> { completion in
      let url = URL(string: "\(NewsEndpoint.Get.topHeadline(country: country).url)\(NewsKit.apiKey)")!
      
      AF.request(url)
        .validate()
        .responseDecodable(of: NewsResponse.self) { response in
          switch response.result {
          case .success(let result):
            completion(.success(result.articles))
          case .failure:
            completion(.failure(NewsError.invalidSerialization))
          }
        }
    }.eraseToAnyPublisher()
  }
}
