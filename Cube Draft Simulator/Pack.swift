import Foundation

struct Pack: CustomStringConvertible {
  let cards: [Card]
  
  var count: Int {
    cards.count
  }

  
  // Mark: CustomStringConvertible
  
  var description: String {
    return "Pack of \(count) cards"
  }
}
