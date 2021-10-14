//
//  File.swift
//  
//
//  Created by Ari Supriatna on 14/10/21.
//

import Foundation
import Combine

public protocol NKNewsUseCase {
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
