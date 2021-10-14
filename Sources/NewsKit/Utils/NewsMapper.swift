//
//  File.swift
//  
//
//  Created by Ari Supriatna on 14/10/21.
//

import Foundation

public final class NKNewsMapper {
  public static func transformResponsesToDomains(responses: [News]) -> [NewsModel] {
    return responses.map {
      let source = NKSourceMapper.transformResponseToDomain(response: $0.source)
      
      return NewsModel(
        author: $0.author ?? "",
        title: $0.title ?? "",
        description: $0.description ?? "",
        url: $0.url ?? "",
        urlToImage: $0.urlToImage ?? "",
        content: $0.content ?? "",
        source: source
      )
    }
  }
}

public final class NKSourceMapper {
  public static func transformResponseToDomain(response: SourceResponse?) -> SourceModel {
    return SourceModel(name: response?.name ?? "")
  }
}
