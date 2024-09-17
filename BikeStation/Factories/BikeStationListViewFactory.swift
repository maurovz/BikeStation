import UIKit
import BikeDataFeature

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
