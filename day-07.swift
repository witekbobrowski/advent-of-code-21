// --- Day 7: The Treachery of Whales ---
// https://adventofcode.com/2021/day/7

import Foundation

func readInput(from path: String) throws -> [Int] {
    let url = URL(fileURLWithPath: path)
    let contents = try String(contentsOf: url, encoding: .utf8)
        .trimmingCharacters(in: .whitespacesAndNewlines)
    return contents.split(separator: ",").compactMap { Int($0) }
}

let input = try readInput(from: "input/day-07.txt")

// MARK: - Part One
print("--- Day 7: The Treachery of Whales ---")

extension Array where Element == Int {
    var median: Double {
        let sorted = sorted()
        if sorted.count % 2 == 0 {
            return Double((sorted[(count / 2)] + sorted[(count / 2) - 1])) / 2
        }
        return Double(sorted[(count - 1) / 2])
    }
}

private func optimalFuelCost(from input: [Int]) -> Int {
    let median = Int(input.median)
    return input.reduce(0) { $0 + abs($1 - median) }
}

print("solution:", optimalFuelCost(from: input))
// Solution: 355592

// MARK: - Part Two
print("--- Part Two ---")

extension Array where Element == Int {
    var mean: Double {
        Double(reduce(0, +)) / Double(count)
    }
}

private func optimalFuelCostNotConstant(from input: [Int]) -> Int? {
    let mean = input.mean
    let positions = Set([Int(ceil(mean)), Int(floor(mean))])
    return positions.map { position in
        input.reduce(0) { $0 + ((0...abs($1 - position)).reduce(0, +)) }
    }.min()
}

print("solution:", optimalFuelCostNotConstant(from: input)!)
// Solution: 101618069
