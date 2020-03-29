import Foundation

struct Card: CustomStringConvertible {
  let name: String
  let type: String
  let archetypeRatings: [String: Int]
  
  init(name: String, type: String, archetypeRatings: [String: Int]) {
    self.name = name
    self.type = type
    self.archetypeRatings = archetypeRatings
  }
  
  var totalValue: Int {
    archetypeRatings.values.reduce(0, +)
  }
  
  var topArchetype: String? {
    archetypeRatings.max { a, b in a.value < b.value }?.key
  }
  
  var topArchetypes: [String] {
    guard archetypeRatings.count > 0 else {
      return []
    }
    let maxRating = archetypeRatings.values.max()
    return archetypeRatings.compactMap { key, value in
      return value == maxRating ? key : nil
    }
  }
  
  
  // Mark: CustomStringConvertible
  
  var description: String {
    let archetypesDescription = topArchetypes.count > 5
      ? "\(topArchetypes.count) archetypes"
      : topArchetypes.joined(separator: ", ")
    return "\(name), \(type), Total Value: \(totalValue), Top Archetypes: \(archetypesDescription)"
  }
  
}
