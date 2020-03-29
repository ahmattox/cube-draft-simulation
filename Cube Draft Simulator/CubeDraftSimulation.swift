import Foundation
import CSV

enum SimulationError: Error {
    case generic(String)
}

struct CubeDraftSimulation {
  let cube: Cube
  var seats: [DraftSeat]
  let packCount = 3
  let packSize = 15
  let seatCount = 8
  
  init(cube: Cube) throws {
    self.cube = cube
    
    if (cube.count < seatCount * packCount * packSize) {
      throw SimulationError.generic("Cube does not have enough cards for the configured draft")
    }
    
    self.seats = (0..<seatCount).map {
      index in DraftSeat(name: "Seat \(index + 1)")
    }
  }
  
  init(csvPath: String) throws {
    try self.init(cube: try Cube(csvPath: csvPath))
  }
  
  init(csvString: String) throws {
    try self.init(cube: try Cube(csvString: csvString))
  }
  
  mutating func run() -> [DraftSeat] {
    let packs = cube.cards.shuffled().chunked(into: packSize).map { Pack(cards: $0) }.chunked(into: seatCount)
    
    for round in 0..<packCount {
      var roundPacks = packs[round];
      
      for pick in 0..<packSize {
        for seat in 0..<seats.count {
          let packIndex = (seat + pick) % seatCount
          print(".", terminator: "")
          
          roundPacks[packIndex] = seats[seat].pick(from: roundPacks[packIndex])
        }
      }
    }
    
    print("")
    
    return seats
  }
}
