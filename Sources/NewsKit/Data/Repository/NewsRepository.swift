//
//  File.swift
//  
//
//  Created by Ari Supriatna on 14/10/21.
//

import Foundation
import Combine
import Alamofire

public protocol NKNewsRepositoryProtocol {
  /// The function for search news
  /// - Parameter query: The query from user input
  /// - Returns: The list of ``NewsModel``
  func searchNews(by query: String) -> AnyPublisher<[NKNewsModel], Error>
  
  /// The function for get news by category
  /// - Parameter category: The category of news ``NewsCategory``
  /// - Returns: The list of ``NewsModel``
  func getNewsByCategory(by category: NKNewsCategory) -> AnyPublisher<[NKNewsModel], Error>
  
  /// The function for get news top headline
  /// - Parameter country: The country from ``CountryCode``
  /// - Returns: The list of ``NewsModel``
  func getNewsTopHeadline(by country: NKCountryCode) -> AnyPublisher<[NKNewsModel], Error>
}

public final class NKNewsRepository: NSObject {
  public typealias NKNewsInstance = (NKNewsRemoteDataSource) -> NKNewsRepository
  
  fileprivate let remote: NKNewsRemoteDataSource
  
  private init(remote: NKNewsRemoteDataSource) {
    self.remote = remote
  }
  
  public static let sharedInstance: NKNewsInstance = { remote in
    return NKNewsRepository(remote: remote)
  }
}

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
