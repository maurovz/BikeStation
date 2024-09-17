import SwiftUI
import BikeDataFeature

@main
struct BikeStationApp: App {
  var body: some Scene {
      WindowGroup {
        BikeStationListViewFactory.create()
      }
  }
}
