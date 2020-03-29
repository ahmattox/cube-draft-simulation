import Foundation
import CSV

struct Cube: CustomStringConvertible {
  let cards: [Card]
  
  init(csvPath: String) throws {
    guard let stream = InputStream(fileAtPath: csvPath) else {
      throw SimulationError.generic("Invalid CSV Path");
    }
    
    guard let csv = try? CSVReader(stream: stream, hasHeaderRow: true) else {
      throw SimulationError.generic("Unable to read CSV at path \(csvPath)");
    }
    
    try self.init(csv: csv)
  }
  
  init(csvString: String) throws {
    try self.init(csv: CSVReader(string: csvString, hasHeaderRow: true))
  }
  
  init(csv: CSVReader) throws {
    let headers = csv.headerRow!
    
    var cards: [Card] = []
    
    while csv.next() != nil {
      let row = csv.currentRow!
      
      var archetypeRatings: [String: Int] = [:]
      
      for speed in 3...5 {
        for color in 6...20 {
          archetypeRatings["\(headers[color]) \(headers[speed])"] = (Int(row[color]) ?? 0) + (Int(row[speed]) ?? 0)
        }
      }
      
      cards.append(
        Card(name: csv["Name"]!, type: csv["Type"]!, archetypeRatings: archetypeRatings)
      )
    }
    
    self.cards = cards
  }
  
  var count: Int {
    cards.count
  }
  
  
  // Mark: CustomStringConvertible
  
  var description: String {
    "Cube:\n  \(cards.map { $0.description }.joined(separator: "\n  "))"
  }
  
}
