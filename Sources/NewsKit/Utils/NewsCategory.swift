//
//  File.swift
//  
//
//  Created by Ari Supriatna on 14/10/21.
//

import Foundation

/// The News Category
///
/// ## Overview
/// The category you want to get headlines for. Note: you can't mix this param with the sources param.
public enum NKNewsCategory: String {
  /// The category of business
  case business

  /// The category of entertainment
  case entertainment

  /// The category of general
  case general

  /// The category of health
  case health

  /// The category of science
  case science

  /// The category of sports
  case sports

  /// The category of technology
  case technology
}
