import Foundation

let csvPath = CommandLine.arguments[1];

do {
  var simulation = try CubeDraftSimulation(csvPath: csvPath)

  let draftPools = simulation.run()
  
  print(draftPools.map { $0.description }.joined(separator: "\n"))
} catch {
  print("Error running draft simulation. ", error)
}
