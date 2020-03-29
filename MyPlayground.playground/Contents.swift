import Cocoa
@testable import CubeDraftSimulatorPlaygroundSupport

let csvPath = Bundle.main.url(forResource: "CubeDraftRatings", withExtension: "csv")!.resolvingSymlinksInPath()

let csvString = try! String(contentsOf: csvPath)


guard var simulation = try? CubeDraftSimulation(csvString: csvString) else {
  fatalError()
}

let decks = simulation.run()

print(decks.map { $0.description }.joined(separator: "\n"))
