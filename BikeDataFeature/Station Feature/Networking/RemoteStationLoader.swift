import Foundation

public final class RemoteStationLoader: StationLoader {
  private let url: URL
  private let client: HTTPClient
  private let cache: CoreDataServices

  public init(url: URL, client: HTTPClient, cache: CoreDataServices) {
    self.url = url
    self.client = client
    self.cache = cache
  }

  public typealias Result = StationLoader.Result

  public func load(completion: @escaping (Result) -> Void) {
    client.get(from: url) { result in
      switch result {
      case .success((let data, _)):
        guard let mappedStation = try? StationMapper.map(data: data) else {
          completion(.failure(StationMapper.Error.invalidData))
          return
        }

        self.setCache(stations: mappedStation)
        completion(.success(mappedStation))

      case .failure(let error):
        let cacheStations = self.cache.loadStationsFromCoreData()
        guard !cacheStations.isEmpty else {
          completion(.failure(error))
          return
        }

        completion(.success(cacheStations))
      }
    }
  }

  private func setCache(stations: [Station]) {
    guard cache.deleteEntityFromCoreData(entity: "StationEntity") else { return }
    cache.saveStationsToCache(stations: stations)
  }
}
