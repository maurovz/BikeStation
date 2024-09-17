import Foundation

public struct Station: Equatable {
  public let id: String
  public let name: String
  public let latitude: Double
  public let longitude: Double
  public let freeBikes: Int
  public let emptySlots: Int?
  public let stationNumber: String

  public init(id: String, name: String, latitude: Double, longitude: Double, freeBikes: Int, emptySlots: Int?, stationNumber: String) {
    self.id = id
    self.name = name
    self.latitude = latitude
    self.longitude = longitude
    self.freeBikes = freeBikes
    self.emptySlots = emptySlots
    self.stationNumber = stationNumber
  }
}
