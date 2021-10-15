/// Register your API Key here.
public struct NewsKit {
  public static var apiKey: String = ""
  
  public static func register(apiKey: String) {
    if apiKey.isEmpty {
      print("API Key is empty")
    } else {
      self.apiKey = apiKey
    }
  }
}
