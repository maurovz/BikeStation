import Foundation

public final class StationMapper {
  public enum Error: Swift.Error {
    case invalidData
  }

  private struct Root: Decodable {
    private let network: Network

    struct Network: Decodable {
      let stations: [RemoteStation]

      struct RemoteStation: Decodable {
        private let id: String
        private let name: String
        private let latitude: Double
        private let longitude: Double
        private let freeBikes: Int
        private let emptySlots: Int?
        private let extra: Extra

        var station: Station {
          return Station(id: id, name: name, latitude: latitude, longitude: longitude, freeBikes: freeBikes, emptySlots: emptySlots, stationNumber: extra.number)
        }

        enum CodingKeys: String, CodingKey {
          case id
          case name
          case latitude
          case longitude
          case freeBikes = "free_bikes"
          case emptySlots = "empty_slots"
          case extra
        }

        struct Extra: Decodable {
          let number: String
        }
      }
    }

    var toModel: [Station]? {
      return network.stations.map { $0.station }
    }
  }

  public static func map(data: Data) throws -> [Station] {
    do {
      let root = try JSONDecoder().decode(Root.self, from: data)
      guard let mappedStation = root.toModel else {
        throw Error.invalidData
      }

      return mappedStation

    } catch {
      throw error
    }
  }
}
