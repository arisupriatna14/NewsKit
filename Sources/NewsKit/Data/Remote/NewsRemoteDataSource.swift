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

/// The News Remote Data Source Async Protocol
/// This is async version
public protocol NKNewsRemoteDataSourceAsyncProtocol: AnyObject {
  /// The function for search news with async version
  /// - Parameter query: The query from user input
  /// - Returns: The list of ``NKNews``
  func searchNews(by query: String) async throws -> [NKNews]

  /// The function for fetch news by category with async version
  /// - Parameter category: The category of news ``NKNewsCategory``
  /// - Returns: The list of ``NKNews``
  func fetchNewsByCategory(by category: NKNewsCategory) async throws -> [NKNews]
  
  /// The function for fetch news top headline with async version
  /// - Parameter country: The country from ``NKCountryCode``
  /// - Returns: The list of ``NKNews``
  func fetchNewsTopHeadline(by country: NKCountryCode) async throws -> [NKNews]
}

/// The News Remote Data Source
public final class NKNewsRemoteDataSource: NSObject {
  private override init() { }
  
  /// The shared instance of ``NKNewsRemoteDataSource``
  public static let sharedInstance = NKNewsRemoteDataSource()
}

private extension NKNewsRemoteDataSource {
  private func afRequest(url: URL) async throws -> Data {
    try await withUnsafeThrowingContinuation { continuation in
      AF.request(url, method: .get)
        .validate()
        .responseData { response in
          if let data = response.data {
            continuation.resume(returning: data)
            return
          }
          
          if let error = response.error {
            continuation.resume(throwing: error)
            return
          }
          
          fatalError("Error while doing Alamofire url request")
        }
    }
  }
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

extension NKNewsRemoteDataSource: NKNewsRemoteDataSourceAsyncProtocol {
  public func searchNews(by query: String) async throws -> [NKNews] {
    guard let url = URL(string: "") else { throw NKNewsError.invalidURL }
    var news: [NKNews] = []
    
    do {
      let response = try await afRequest(url: url)
      let decodedData = try JSONDecoder().decode(NKNewsResponse.self, from: response)
      
      news = decodedData.articles
    } catch {
      throw NKNewsError.invalidSerialization
    }
    
    return news
  }
  
  public func fetchNewsByCategory(by category: NKNewsCategory) async throws -> [NKNews] {
    guard let url = URL(string: "") else { throw NKNewsError.invalidURL }
    var news: [NKNews] = []
    
    do {
      let response = try await afRequest(url: url)
      let decodedData = try JSONDecoder().decode(NKNewsResponse.self, from: response)
      news = decodedData.articles
    } catch {
      throw NKNewsError.invalidSerialization
    }
    
    return news
  }
  
  public func fetchNewsTopHeadline(by country: NKCountryCode) async throws -> [NKNews] {
    guard let url = URL(string: "") else { throw NKNewsError.invalidURL }
    var news: [NKNews] = []
    
    do {
      let response = try await afRequest(url: url)
      let decodedData = try JSONDecoder().decode(NKNewsResponse.self, from: response)
      news = decodedData.articles
    } catch {
      throw NKNewsError.invalidSerialization
    }
    
    return news
  }
}
