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

  @Published var fileteredStations: [StationItemViewModel] = []

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
      let fileteredValues = stations.filter { $0.name.contains(value) }
      DispatchQueue.main.async { [weak self] in
        self?.fileteredStations = fileteredValues
      }
    }

    public func resetFilter() {
      fileteredStations =  stations
    }

    private func setStations(_ value: [Station]) {
      let mappedCStations = value.map { StationItemViewModel(station: $0) }
      stations = mappedCStations
      fileteredStations = stations
    }
}
