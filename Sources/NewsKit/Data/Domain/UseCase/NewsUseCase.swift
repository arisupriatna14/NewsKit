//
//  File.swift
//  
//
//  Created by Ari Supriatna on 14/10/21.
//

import Foundation
import Combine

public protocol NewsUseCase {
  /// The function for search news
  /// - Parameter query: The query from user input
  /// - Returns: The list of ``NewsModel``
  func searchNews(by query: String) -> AnyPublisher<[NewsModel], Error>
  
  /// The function for get news by category
  /// - Parameter category: The category of news ``NewsCategory``
  /// - Returns: The list of ``NewsModel``
  func getNewsByCategory(by category: NewsCategory) -> AnyPublisher<[NewsModel], Error>
  
  /// The function for get news top headline
  /// - Parameter country: The country from ``CountryCode``
  /// - Returns: The list of ``NewsModel``
  func getNewsTopHeadline(by country: CountryCode) -> AnyPublisher<[NewsModel], Error>
}
