//
//  File.swift
//  
//
//  Created by Ari Supriatna on 14/10/21.
//

import Foundation

public class APIService {
  public static let baseURL = "https://newsapi.org/v2"
}

public protocol Endpoint {
  var url: String { get }
}

public enum NewsEndpoint {
  public enum Get: Endpoint {
    case search(query: String)
    case topHeadline(country: CountryCode)
    case category(category: NewsCategory)
    
    public var url: String {
      switch self {
      case .search(let query): return "\(APIService.baseURL)/everything?q=\(query)&apiKey="
      case .topHeadline(let country): return "\(APIService.baseURL)/top-headlines?country=\(country.rawValue)&apiKey="
      case .category(let category): return "\(APIService.baseURL)/top-headlines?category=\(category.rawValue)&apiKey="
      }
    }
  }
}
