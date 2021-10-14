//
//  NewsModel.swift
//  
//
//  Created by Ari Supriatna on 14/10/21.
//

import Foundation

public struct NewsModel: Equatable {
  /// The author of the article
  public let author: String
  /// The headline or title of the article
  public let title: String
  /// A description or snippet from the article
  public let description: String
  /// The direct URL to the article
  public let url: String
  /// The URL to a relevant image for the article
  public let urlToImage: String
  /// The unformatted content of the article, where available. This is truncated to 200 chars.
  public let content: String
  /// The display name ``SourceModel/name`` for the source this article came from
  public let source: SourceModel
}

/// The Source Response
public struct SourceModel: Equatable {
  /// The name of source news
  public let name: String
}
