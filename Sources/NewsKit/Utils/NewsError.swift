//
//  File.swift
//  
//
//  Created by Ari Supriatna on 14/10/21.
//

import Foundation

public enum NKNewsError: Error {
  case invalidURL
  case invalidSerialization
  case badHTTPResponse
  case error(NSError)
  case noData
}
