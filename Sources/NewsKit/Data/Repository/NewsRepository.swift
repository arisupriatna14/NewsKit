//
//  File.swift
//  
//
//  Created by Ari Supriatna on 14/10/21.
//

import Foundation
import Combine
import Alamofire

/// The News Repository Protocol
public protocol NKNewsRepositoryProtocol {
  /// The function for search news
  /// - Parameter query: The query from user input
  /// - Returns: The list of ``NKNewsModel``
  func searchNews(by query: String) -> AnyPublisher<[NKNewsModel], Error>
  
  /// The function for get news by category
  /// - Parameter category: The category of news ``NKNewsCategory``
  /// - Returns: The list of ``NKNewsModel``
  func getNewsByCategory(by category: NKNewsCategory) -> AnyPublisher<[NKNewsModel], Error>
  
  /// The function for get news top headline
  /// - Parameter country: The country from ``NKCountryCode``
  /// - Returns: The list of ``NKNewsModel``
  func getNewsTopHeadline(by country: NKCountryCode) -> AnyPublisher<[NKNewsModel], Error>
}

/// The News Repository Async Protocol
public protocol NKNewsRepositoryAsyncProtocol: AnyObject {
  /// The function for search news with async version
  /// - Parameter query: The query from user input
  /// - Returns: The list of ``NKNewsModel``
  func searchNews(by query: String) async throws -> [NKNewsModel]
  
  /// The function for fetch news by category with async version
  /// - Parameter category: The category of news ``NKNewsCategory``
  /// - Returns: The list of ``NKNewsModel``
  func getNewsByCategory(by category: NKNewsCategory) async throws -> [NKNewsModel]
  
  /// The function for fetch news top headline with async version
  /// - Parameter country: The country from ``NKCountryCode``
  /// - Returns: The list of ``NKNewsModel``
  func getNewsTopHeadline(by country: NKCountryCode) async throws -> [NKNewsModel]
}

/// The News Repository
public final class NKNewsRepository: NSObject {
  /// The News Instance
  public typealias NKNewsInstance = (NKNewsRemoteDataSource) -> NKNewsRepository
  
  fileprivate let remote: NKNewsRemoteDataSource
  
  private init(remote: NKNewsRemoteDataSource) {
    self.remote = remote
  }
  
  /// The news repository shared instance
  public static let sharedInstance: NKNewsInstance = { remote in
    return NKNewsRepository(remote: remote)
  }
}

/// The extension of `NKNewsRepository` with implementation ``NKNewsRepositoryProtocol``
extension NKNewsRepository: NKNewsRepositoryProtocol {
  public func searchNews(by query: String) -> AnyPublisher<[NKNewsModel], Error> {
    return remote.searchNews(by: query)
      .map { NKNewsMapper.transformResponsesToDomains(responses: $0) }
      .eraseToAnyPublisher()
  }
  
  public func getNewsByCategory(by category: NKNewsCategory) -> AnyPublisher<[NKNewsModel], Error> {
    return remote.fetchNewsByCategory(by: category)
      .map { NKNewsMapper.transformResponsesToDomains(responses: $0) }
      .eraseToAnyPublisher()
  }
  
  public func getNewsTopHeadline(by country: NKCountryCode) -> AnyPublisher<[NKNewsModel], Error> {
    return remote.fetchNewsTopHeadline(by: country)
      .map { NKNewsMapper.transformResponsesToDomains(responses: $0) }
      .eraseToAnyPublisher()
  }
}

/// The extension of `NKNewsRepository` with implementation ``NKNewsRepositoryAsyncProtocol``
extension NKNewsRepository: NKNewsRepositoryAsyncProtocol {
  public func searchNews(by query: String) async throws -> [NKNewsModel] {
    return try await NKNewsMapper.transformResponsesToDomains(responses: remote.searchNews(by: query))
  }
  
  public func getNewsByCategory(by category: NKNewsCategory) async throws -> [NKNewsModel] {
    return try await NKNewsMapper.transformResponsesToDomains(responses: remote.fetchNewsByCategory(by: category))
  }
  
  public func getNewsTopHeadline(by country: NKCountryCode) async throws -> [NKNewsModel] {
    return try await NKNewsMapper.transformResponsesToDomains(responses: remote.fetchNewsTopHeadline(by: country))
  }
}
