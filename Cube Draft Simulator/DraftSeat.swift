import Foundation

struct DraftSeat: CustomStringConvertible {
  let name: String
  var picks: [Card] = []
  
  mutating func pick(from pack: Pack) -> Pack {
    assert(pack.count > 0, "Cannot pick from an empty pack");
    
    var cards = pack.cards;
    
    let pick = cards.enumerated().max { (a, b) -> Bool in
      return score(forCard: a.element, withPicks: picks)  < score(forCard: b.element, withPicks: picks)
      }!
    
    picks.append(
      cards.remove(at: pick.offset)
    )
    
    return Pack(cards: cards)
  }
  
  private func score(forCard card:Card, withPicks pick: [Card]) -> Int {
    if (picks.count < 5) {
      return card.totalValue
    } else {
      return archetypeScore(forCard: card, withPicks: picks)
    }
  }
  
  private func archetypeScore(forCard card:Card, withPicks picks: [Card]) -> Int {
    let cards = picks + [card]
    
    let archetypeRatings: [String: Int] = cards.reduce([:]) { (archetypes, card) in
      sum(archetypes, card.archetypeRatings)
    }
    
    return archetypeRatings.values.max() ?? 0
  }
  
  var archetypes: [String] {
    let archetypeRatings: [String: Int] = picks.reduce([:]) { (archetypes, card) in
      sum(archetypes, card.archetypeRatings)
    }

    let maxRating = archetypeRatings.values.max()
    return archetypeRatings.compactMap { key, value in
      return value == maxRating ? key : nil
    }
  }
  
  
  // Mark: - CustomStringConvertible
  
  var description: String {
    let archetypeDescription = archetypes.joined(separator: ", ")
    let picksDescription = picks.map { card in
      card.name
    }.joined(separator: "\n  ")
    return "\(name) - \(archetypeDescription):\n  \(picksDescription)"
  }
}
