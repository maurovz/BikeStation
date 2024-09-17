import SwiftUI

struct BikeStationListView: View {
  @ObservedObject var viewModel: BikeStationsViewModel
  @EnvironmentObject var locationManager: LocationManager
  @Environment(\.openURL) var openURL

  init(viewModel: BikeStationsViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    ScrollView {
      VStack(alignment: .leading) {
        Text("Bike Station List!") //TODO: Localization
          .font(.title)
          .padding(.bottom)

        ForEach(viewModel.filteredStations) { station in
          VStack(alignment: .leading) {
            HStack {
              Text(station.name)
              Spacer()
              Text("Station number: \(station.stationNumber)")
            }
            HStack {
              Text("Bikes available: \(station.freeBikes)")
              Spacer()
              Text("Empty slots: \(station.emptySlots)")
            }
          }
          .padding()
          .onTapGesture {
            openURL(viewModel.getCoordinatesUrl(station: station))
          }
          .background(Color.gray.opacity(0.1))
          .cornerRadius(8)
        }
      }
      .padding(.horizontal)
    }
    .refreshable {
      viewModel.fetch()
    }
    .task {
      viewModel.fetch()
    }
  }
}


#Preview {
  BikeStationListViewFactory.create()
}
