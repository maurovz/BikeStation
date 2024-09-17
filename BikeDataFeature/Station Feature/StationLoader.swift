import Foundation

public protocol StationLoader {
  typealias Result = Swift.Result<[Station], Swift.Error>

  func load(completion: @escaping (Result) -> Void)
}
