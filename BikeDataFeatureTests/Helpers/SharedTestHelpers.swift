import Foundation
import BikeDataFeature

func makeStation(
  id: String,
  name: String,
  latitude: Double,
  longitude: Double
) -> (model: [Station], json: [String: Any]) {

  let json: [String: Any] = [
    "id": id,
    "name": name,
    "latitude": latitude,
    "longitude": longitude
  ]

  let model = Station(id: id, name: name, latitude: latitude, longitude: longitude)

  return ([model], json)
}

func makeJSON(_ item: [String: Any]) -> Data {
  let root = ["data": ["results": [item]]]
  return try! JSONSerialization.data(withJSONObject: root)
}
