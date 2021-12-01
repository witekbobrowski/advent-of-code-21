// --- Day 1: Sonar Sweep ---
// https://adventofcode.com/2021/day/1

import Foundation

func readInput(from path: String) throws -> [Int] {
    let url = URL(fileURLWithPath: path)
    let contents = try String(contentsOf: url, encoding: .utf8)
    return contents.split(separator: "\n").compactMap { Int($0) }
}
let input = try readInput(from: "input/day-01.txt")

// MARK: - Part One
print("--- Day 1: Sonar Sweep ---")

private func countNumberOfIncreases(from input: [Int]) -> Int {
    input.indices.dropFirst().reduce(0) { sum, index in
        input[index - 1] < input[index] ? sum + 1 : sum
    }
}

print("Solution:", countNumberOfIncreases(from: input))
// Solution: 1521

// MARK: - Part Two
print("--- Part Two ---")

private func countNumberOfIncreasesSlidingWindows(from input: [Int]) -> Int {
    input.indices.dropFirst(3).reduce(0) { sum, index in
        let previous = input[index - 3] + input[index - 2] + input[index - 1]
        let current = input[index - 2] + input[index - 1] + input[index]
        return previous < current ? sum + 1 : sum
    }
}

print("Solution:", countNumberOfIncreasesSlidingWindows(from: input))
// Solution: 1543
