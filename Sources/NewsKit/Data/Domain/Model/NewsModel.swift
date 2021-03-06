//
//  NewsModel.swift
//  
//
//  Created by Ari Supriatna on 14/10/21.
//

import Foundation

/// Thew News Model
public struct NKNewsModel: Equatable, Identifiable {
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

  /// The display name ``NKSourceModel/name`` for the source this article came from
  public let source: NKSourceModel
  
  /// Initializer of `NKNewsModel`
  public init(
    author: String,
    title: String,
    description: String,
    url: String,
    urlToImage: String,
    source: NKSourceModel
  ) {
    self.author = author
    self.title = title
    self.description = description
    self.url = url
    self.urlToImage = urlToImage
    self.source = source
  }
}

/// The Source Model
public struct NKSourceModel: Equatable {
  /// The name of source news
  public let name: String
  
  /// Initializer of `NKSourceModel`
  public init(name: String) {
    self.name = name
  }
}

/// Extension for data stub `NKNewsModel`
extension NKNewsModel {
  /// Example data for `NKNewsModel`
  public static var stub: NKNewsModel {
    .init(
      author: "ABC Australia",
      title: "Vaksin COVID-19 yang Mulai Disuntikkan Pekan Ini, Adakah Efek Sampingnya? - detikNews",
      description: "Pekan ini, Inggris akan melaksanakan vaksinasi COVID-19 kepada warganya. Namun, masih banyak pertanyaan seputar vaksin yang hingga kini belum terjawab.",
      url: "https://news.detik.com/abc-australia/d-5286211/vaksin-covid-19-yang-mulai-disuntikkan-pekan-ini-adakah-efek-sampingnya",
      urlToImage: "https://awsimages.detik.net.id/api/wm/2020/12/08/vaksin-covid-19-yang-mulai-disuntikkan-pekan-ini-adakah-efek-sampingnya_169.jpeg?wid=54&w=650&v=1&t=jpeg",
      source: NKSourceModel(name: "Detik.com")
    )
  }
}
