// --- Day 3: Binary Diagnostic ---
// https://adventofcode.com/2021/day/3

import Foundation

func readInput(from path: String) throws -> [String] {
    let url = URL(fileURLWithPath: path)
    let contents = try String(contentsOf: url, encoding: .utf8)
    return contents.split(separator: "\n").compactMap(String.init)
}
let input = try readInput(from: "input/day-03.txt")

// MARK: - Part One
print("--- Day 3: Binary Diagnostic ---")

private func getPowerConsumtion(from input: [String]) -> Int {
    let gamma = input.reduce([Int]()) { (count, bits) in
        if count.isEmpty { return bits.map { $0 == "0" ? 0 : 1 } }
        return zip(count, bits).map { (count, bit) in
            count + (bit == "0" ? 0 : 1)
        }
    }.map { ($0 < input.count / 2) ? "0" : "1" }.joined(separator: "")
    let epsilon = gamma.map { $0 == "0" ? "1" : "0" }.joined(separator: "")
    return Int(strtoul(gamma, nil, 2)) * Int(strtoul(epsilon, nil, 2))
}

print("Solution:", getPowerConsumtion(from: input))
// Solution: 2743844

// MARK: - Part Two
print("--- Part Two ---")

