import Foundation
import BikeDataFeature

class StationItemViewModel: Identifiable {
  lazy var id: String = {
    station.id
  }()

  lazy var name: String = {
    station.name
  }()

  lazy var latitude: Double = {
    station.latitude
  }()

  lazy var longitude: Double = {
    station.longitude
  }()

  lazy var freeBikes: Int = {
    station.freeBikes
  }()

  lazy var emptySlots: Int = {
    station.emptySlots ?? 0
  }()

  lazy var stationNumber: String = {
    station.stationNumber
  }()

  private let station: Station

  init(station: Station) {
    self.station = station
  }
}
