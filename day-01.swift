import Foundation 

func readInput(from path: String) -> [Int] {
    let url = URL(fileURLWithPath: path)
    let contents = try? String(contentsOf: url, encoding: .utf8)
    return contents?.split(separator: "\n").compactMap { Int($0) } ?? []
}

print("--- Day 1: Sonar Sweep ---")

let input = readInput(from: "input/day-01.txt")

// MARK: - Part One
private func countNumberOfIncreases(from input: [Int]) -> Int {
    var lastValue: Int?
    return input.reduce(0) { sum, value in
        defer { lastValue = value }
        return lastValue.map { $0 < value ? sum + 1 : sum } ?? sum
    }
}

print("Solution:", countNumberOfIncreases(from: input))
// Solution: 1521

