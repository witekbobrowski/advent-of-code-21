// --- Day 3: Binary Diagnostic ---
// https://adventofcode.com/2021/day/3

import Foundation

func readInput(from path: String) throws -> [String] {
    let url = URL(fileURLWithPath: path)
    let contents = try String(contentsOf: url, encoding: .utf8)
    return contents.split(separator: "\n").map(String.init)
}
let input = try readInput(from: "input/day-03.txt")

// MARK: - Part One
print("--- Day 3: Binary Diagnostic ---")

private func getPowerConsumtion(from input: [String]) -> Int {
    let gamma = input.reduce([Int]()) { (count, bits) in
        if count.isEmpty { return bits.map { $0 == "0" ? 0 : 1 } }
        return zip(count, bits).map { $0 + (Int(String($1)) ?? 0) }
    }.map { ($0 * 2 < input.count) ? "0" : "1" }.joined()
    let epsilon = gamma.map { $0 == "0" ? "1" : "0" }.joined()
    return Int(strtoul(gamma, nil, 2)) * Int(strtoul(epsilon, nil, 2))
}

print("Solution:", getPowerConsumtion(from: input))
// Solution: 2743844

// MARK: - Part Two
print("--- Part Two ---")

private func findMostCommonBits(from input: [String]) -> String {
    input.reduce([Int]()) { (count, bits) in
        if count.isEmpty { return bits.map { $0 == "0" ? 0 : 1 } }
        return zip(count, bits).map { $0 + (Int(String($1)) ?? 0) }
    }
    .map { ($0 * 2 < input.count) ? "0" : ($0 * 2 == input.count ? "-" : "1") }
    .joined()
}

private func findCandidate(
    from input: [String], leadingBit: Character, matchesMostsCommonBit: Bool
) -> String? {
    var candidates = input
    var bitIndex = "".startIndex
    while candidates.count > 1 {
        let mostCommonBits = findMostCommonBits(from: candidates)
        candidates = candidates.filter { candidate in
            if mostCommonBits[bitIndex] == "-" {
                return candidate[bitIndex] == leadingBit
            } else if matchesMostsCommonBit {
                return candidate[bitIndex] == mostCommonBits[bitIndex]
            } else {
                return candidate[bitIndex] != mostCommonBits[bitIndex]
            }
        }
        bitIndex = mostCommonBits.index(after: bitIndex)
    }
    return candidates.first
}

private func getLifeSupportRating(from input: [String]) -> Int {
    let oxygenGeneratorRating = findCandidate(
        from: input, leadingBit: "1", matchesMostsCommonBit: true
    )!
    let co2ScrubberRating = findCandidate(
        from: input, leadingBit: "0", matchesMostsCommonBit: false
    )!

    return Int(strtoul(oxygenGeneratorRating, nil, 2)) * Int(strtoul(co2ScrubberRating, nil, 2))
}

print("Solution:", getLifeSupportRating(from: input))
// Solution: 6677951
