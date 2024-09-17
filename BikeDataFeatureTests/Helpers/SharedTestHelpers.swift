import Foundation
import BikeDataFeature

func makeStation(
  id: String,
  name: String,
  latitude: Double,
  longitude: Double,
  freeBikes: Int,
  emptySlots: Int,
  stationNumber: String
) -> (model: [Station], json: [String: Any]) {

  let json: [String: Any] = [
    "id": id,
    "name": name,
    "latitude": latitude,
    "longitude": longitude,
    "free_bikes": freeBikes,
    "empty_slots": emptySlots,
    "extra": ["number": stationNumber]
  ]

  let model = Station(id: id, name: name, latitude: latitude, longitude: longitude, freeBikes: freeBikes, emptySlots: emptySlots, stationNumber: stationNumber)

  return ([model], json)
}

func makeJSON(_ item: [String: Any]) -> Data {
  let root = ["network": ["stations": [item]]]
  return try! JSONSerialization.data(withJSONObject: root)
}
