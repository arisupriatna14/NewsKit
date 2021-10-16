//
//  File.swift
//  
//
//  Created by Ari Supriatna on 14/10/21.
//

import Foundation

/// The News Error
public enum NKNewsError: Error {
  /// The invalid of URL
  case invalidURL

  /// The invalid of serialization
  case invalidSerialization

  /// The bad HTTP responnse
  case badHTTPResponse

  /// Error
  case error(NSError)

  /// No data
  case noData
}
