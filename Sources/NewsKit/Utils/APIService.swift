//
//  File.swift
//  
//
//  Created by Ari Supriatna on 14/10/21.
//

import Foundation

/// The API Service
public class NKAPIService {
  public static let baseURL = "https://newsapi.org/v2"
}

public protocol NKEndpoint {
  var url: String { get }
}

/// The News Endpoint
public enum NKNewsEndpoint {
  public enum Get: NKEndpoint {
    case search(query: String)
    case topHeadline(country: NKCountryCode)
    case category(category: NKNewsCategory)
    
    public var url: String {
      switch self {
      case .search(let query): return "\(NKAPIService.baseURL)/everything?q=\(query)&apiKey="
      case .topHeadline(let country): return "\(NKAPIService.baseURL)/top-headlines?country=\(country.rawValue)&apiKey="
      case .category(let category): return "\(NKAPIService.baseURL)/top-headlines?category=\(category.rawValue)&apiKey="
      }
    }
  }
}
