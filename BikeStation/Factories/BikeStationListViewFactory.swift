import BikeDataFeature

struct BikeStationListViewFactory {
  static func create() -> BikeStationListView {
    let viewModel = BikeStationsViewModel(loader: getLoader())
    return BikeStationListView(viewModel: viewModel)
  }

  static func getLoader() -> RemoteStationLoader {
    let client = URLSessionHTTPClient(session: .shared)
    return RemoteStationLoader(url: Constants.url, client: client, cache: CoreDataServices())
  }
}
