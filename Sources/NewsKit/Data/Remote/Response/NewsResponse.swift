//
//  NewsResponse.swift
//  
//
//  Created by Ari Supriatna on 13/10/21.
//

import Foundation

/// The NewsResponse for handle response from API
public struct NKNewsResponse: Decodable {
  /// The results of the request
  public let articles: [NKNews]
}

/// The News Response
public struct NKNews: Decodable {
  /// The author of the article
  public let author: String?
  /// The headline or title of the article
  public let title: String?
  /// A description or snippet from the article
  public let description: String?
  /// The direct URL to the article
  public let url: String?
  /// The URL to a relevant image for the article
  public let urlToImage: String?
  /// The unformatted content of the article, where available. This is truncated to 200 chars.
  public let content: String?
  /// The display name ``NKSourceResponse/name`` for the source this article came from
  public let source: NKSourceResponse?
}

/// The Source Response
public struct NKSourceResponse: Decodable {
  /// The name of source news
  public let name: String?
}
