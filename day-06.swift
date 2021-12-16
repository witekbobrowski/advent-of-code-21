// --- Day 6: Lanternfish ---
// https://adventofcode.com/2021/day/6

import Foundation

func readInput(from path: String) throws -> [Int] {
    let url = URL(fileURLWithPath: path)
    let contents = try String(contentsOf: url, encoding: .utf8)
    return contents.compactMap { $0 == "," ? nil : Int(String($0)) }
}
let input = try readInput(from: "input/day-06.txt")

// MARK: - Part One
print("--- Day 6: Lanternfish ---")

private func reproduce(_ timer: Int, days: Int) -> Int {
    if days <= timer { return 1 }
    if timer == 0 {
        return reproduce(0, days: days - 7) + reproduce(0, days: days - 9)
    }
    return reproduce(0, days: days - timer)
}

print("Solution:", input.reduce(0) { $0 + reproduce($1, days: 80) })
// Solution: 372984

// MARK: - Part Two
print("--- Part Two ---")

private func reproduceInBuckets(_ input: [Int], days: Int) -> Int {
    var buckets = [Int](repeating: 0, count: 9)
    input.forEach { buckets[$0] += 1 }
    (1...days).forEach { _ in
        var stash = 0
        buckets.indices.reversed().forEach { swap(&stash, &buckets[$0]) }
        buckets[6] += stash
        buckets[8] += stash
    }
    return buckets.reduce(0, +)
}

print("Solution:", reproduceInBuckets(input, days: 256))
// Solution: 1681503251694
