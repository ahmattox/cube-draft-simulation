import Foundation

extension Array {
  func chunked(into size: Int) -> [[Element]] {
    return stride(from: 0, to: count, by: size).map {
      Array(self[$0 ..< Swift.min($0 + size, count)])
    }
  }
}

func sum(_ lhs: [String: Int], _ rhs: [String: Int]) -> [String: Int] {
  let allKeys = Array(lhs.keys) + Array(rhs.keys)
  
  return allKeys.reduce([:]) { (sum, key) in
    var sum = sum
    sum[key] = (lhs[key] ?? 0) + (rhs[key] ?? 0)
    return sum
  }
}
