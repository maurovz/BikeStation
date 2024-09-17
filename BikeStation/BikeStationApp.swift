import SwiftUI
import BikeDataFeature

@main
struct BikeStationApp: App {
  @StateObject private var locationManager = LocationManager()

  var body: some Scene {
      WindowGroup {
        BikeStationListViewFactory.create()
          .environmentObject(locationManager)
      }
  }
}
