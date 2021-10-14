//
//  NewsModel.swift
//  
//
//  Created by Ari Supriatna on 14/10/21.
//

import Foundation

public struct NewsModel: Equatable, Identifiable {
  /// The id of the article
  public let id = UUID()
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
  
  public init(
    author: String,
    title: String,
    description: String,
    url: String,
    urlToImage: String,
    content: String,
    source: SourceModel
  ) {
    self.author = author
    self.title = title
    self.description = description
    self.url = url
    self.urlToImage = urlToImage
    self.content = content
    self.source = source
  }
}

/// The Source Response
public struct SourceModel: Equatable {
  /// The name of source news
  public let name: String
  
  public init(name: String) {
    self.name = name
  }
}

extension NewsModel {
  
  public static var stub: NewsModel {
    .init(
      author: "ABC Australia",
      title: "Vaksin COVID-19 yang Mulai Disuntikkan Pekan Ini, Adakah Efek Sampingnya? - detikNews",
      description: "Pekan ini, Inggris akan melaksanakan vaksinasi COVID-19 kepada warganya. Namun, masih banyak pertanyaan seputar vaksin yang hingga kini belum terjawab.",
      url: "https://news.detik.com/abc-australia/d-5286211/vaksin-covid-19-yang-mulai-disuntikkan-pekan-ini-adakah-efek-sampingnya",
      urlToImage: "https://awsimages.detik.net.id/api/wm/2020/12/08/vaksin-covid-19-yang-mulai-disuntikkan-pekan-ini-adakah-efek-sampingnya_169.jpeg?wid=54&w=650&v=1&t=jpeg",
      content: "Canberra - Pekan ini Inggris dijadwalkan akan melaksanakan vaksinasi COVID-19 kepada warganya. Namun, banyak pertanyaan seputar vaksin yang hingga kini belum terjawab.\r\nSementara di Australia sendiri… [+5777 chars]",
      source: SourceModel(name: "Detik.com")
    )
  }
  
}
