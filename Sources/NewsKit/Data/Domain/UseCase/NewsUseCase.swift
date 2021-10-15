//
//  File.swift
//  
//
//  Created by Ari Supriatna on 14/10/21.
//

import Foundation
import Combine

/// The News Use Case
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

/// The News Use Case with Async version
public protocol NKNewsUseCaseAsync {
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
