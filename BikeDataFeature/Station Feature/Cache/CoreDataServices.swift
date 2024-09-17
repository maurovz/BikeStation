import CoreData

public struct CoreDataServices {
  public init() { }

  public func saveStationsToCache(stations: [Station]) {
    let context = CoreDataStack.persistentContainer.viewContext

    for station in stations {
      let entity = StationEntity(context: context)
      entity.id = station.id
      entity.name = station.name
      entity.longitude = station.longitude
      entity.longitude = station.latitude
      CoreDataStack.saveContext()
    }
  }

  public func loadStationsFromCoreData() -> [Station] {
    let entities = fetchStationEntity()
    var stations: [Station] = []

    for entity in entities {
      guard
        let id = entity.id,
        let name = entity.name
      else {
        continue
      }

      stations.append(Station(id: id, name: name, latitude: entity.latitude, longitude: entity.longitude))
    }

    return stations
  }

  public func deleteEntityFromCoreData(entity: String) -> Bool {
    let context = CoreDataStack.persistentContainer.viewContext
    do {
      let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
      let request = NSBatchDeleteRequest(fetchRequest: fetch)
      try context.execute(request)
      return true
    } catch {
      return false
    }
  }

  private func fetchStationEntity() -> [StationEntity] {
    let context = CoreDataStack.persistentContainer.viewContext
    do {
      return try context.fetch(StationEntity.fetchRequest())
    } catch {
      return []
    }
  }
}
