import Foundation
import BikeDataFeature

protocol BikeStationViewProtocol: AnyObject {
  func showError(message: String)
  func didLoadData()
}

class BikeStationsViewModel: ObservableObject {
  typealias SelectionAction = (StationItemViewModel) -> Void?

  private let loader: StationLoader
  private var stations: [StationItemViewModel] = []

  @Published var filteredStations: [StationItemViewModel] = []

  public weak var delegate: BikeStationViewProtocol?

  public var didSelectAction: SelectionAction

  init(loader: StationLoader, didSelectAction: @escaping SelectionAction) {
    self.loader = loader
    self.didSelectAction = didSelectAction
  }

  public func fetch() {
    loader.load { [weak self] result in
      guard let self = self else { return }

      switch result {
      case .success(let stations):
        DispatchQueue.main.async {
          self.setStations(stations)
          self.delegate?.didLoadData()
        }

      case .failure(let error):
        DispatchQueue.main.async {
          self.delegate?.showError(message: error.localizedDescription)
        }
      }
    }
  }

  public func filterResults(value: String) {
    let filteredValues = stations.filter { $0.name.contains(value) }

    let sortedValues = filteredValues.sorted {
      $0.distance(from: LocationManager.currentlocation) < $1.distance(from: LocationManager.currentlocation)
    }

    DispatchQueue.main.async { [weak self] in
      self?.filteredStations = sortedValues
    }
  }

  public func resetFilter() {
    filteredStations =  stations
  }

  private func setStations(_ value: [Station]) {
    let mappedCStations = value.map { StationItemViewModel(station: $0) }
    stations = mappedCStations
    filteredStations = stations
  }
}
