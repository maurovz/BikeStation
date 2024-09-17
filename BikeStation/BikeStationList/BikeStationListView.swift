import SwiftUI

struct BikeStationListView: View {
  @ObservedObject var viewModel: BikeStationsViewModel

  init(viewModel: BikeStationsViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    ScrollView {
      VStack {
        Text("Bike Station List!")
        ForEach(viewModel.fileteredStations) { station in
          Text(station.name)
            .onTapGesture {
              viewModel.didSelectAction(station)
            }
        }
      }
    }
    .task {
      viewModel.fetch()
    }
  }
}

#Preview {
  ContentView()
}
