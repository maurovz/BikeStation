import SwiftUI

struct BikeStationListView: View {
  @ObservedObject var viewModel: BikeStationsViewModel
  @EnvironmentObject var locationManager: LocationManager

  init(viewModel: BikeStationsViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    ScrollView {
      VStack(alignment: .leading) {
        Text("Bike Station List!")
          .font(.title)
          .padding(.bottom)

        ForEach(viewModel.fileteredStations) { station in
          VStack(alignment: .leading) {
            HStack {
              Text(station.name)
              Spacer()
              Text("Station number: 324")
            }
            HStack {
              Text("Bikes available: 3")
              Spacer() // Ensure proper alignment
              Text("Empty slots: 2")
            }
          }
          .padding()
          .onTapGesture {
            viewModel.didSelectAction(station)
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
