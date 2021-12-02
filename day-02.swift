// --- Day 2: Dive! ---
// https://adventofcode.com/2021/day/2

import Foundation

enum Move: String {
    case forward
    case down
    case up
}

func readInput(from path: String) throws -> [(Move, Int)] {
    let url = URL(fileURLWithPath: path)
    let contents = try String(contentsOf: url, encoding: .utf8)
    return contents.split(separator: "\n").compactMap { line in
        let components = line.split(separator: " ")
        guard let move = Move(rawValue: String(components[0])), let value = Int(components[1]) else {
            return nil
        }
        return (move, value)
    }
}
let input = try readInput(from: "input/day-02.txt")

// MARK: - Part One
print("--- Day 2: Dive! ---")

private func calculatePosition(from input: [(Move, Int)]) -> Int {
    let position = input.reduce((0, 0)) { position, move in
        let (move, value) = move
        switch move {
        case .forward:
            return (position.0 + value, position.1)
        case .down:
            return (position.0, position.1 + value)
        case .up:
            return (position.0, position.1 - value)
        }
    }
    return position.0 * position.1
}

print("Solution:", calculatePosition(from: input))
// Solution: 1728414

// MARK: - Part Two
print("--- Part Two ---")

private func calculateAim(from input: [(Move, Int)]) -> Int {
    let position = input.reduce((0, 0, 0)) { position, move in
        let (move, value) = move
        switch move {
        case .forward:
            return (position.0 + value, position.1 + value * position.2, position.2)
        case .down:
            return (position.0, position.1, position.2 + value)
        case .up:
            return (position.0, position.1, position.2 - value)
        }
    }
    return position.0 * position.1
}

print("Solution:", calculateAim(from: input))
// Solution: 1765720035
