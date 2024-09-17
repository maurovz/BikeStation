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

  private let station: Station

  init(station: Station) {
    self.station = station
  }
}
