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

struct BikeStationListViewFactory {
  static func create() -> BikeStationListView {
    let viewModel = BikeStationsViewModel(loader: getLoader(), didSelectAction: openMapCoordinates)
    return BikeStationListView(viewModel: viewModel)
  }

  static func getLoader() -> RemoteStationLoader {
    let client = URLSessionHTTPClient(session: .shared)
    return RemoteStationLoader(url: Constants.url, client: client, cache: CoreDataServices())
  }
}

func openMapCoordinates(for viewModel: StationItemViewModel) {
  let urlString = "http://maps.apple.com/?ll=\(viewModel.latitude),\(viewModel.longitude)"
  UIApplication.shared.open(URL(string: urlString)!, options: [:], completionHandler: nil)
}

struct Constants {
  static let url = URL(string: "https://api.citybik.es/v2/networks/wienmobil-rad")!
}
