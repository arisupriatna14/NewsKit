public class NewsKit {
  public private(set) var apiKey: String = ""
  
  public func register(apiKey: String) {
    if apiKey.isEmpty {
      print("API Key is empty")
      fatalError("Api Key is empty")
    } else {
      self.apiKey = apiKey
    }
  }
}
