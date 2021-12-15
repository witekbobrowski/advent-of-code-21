// --- Day 5: Hydrothermal Venture ---
// https://adventofcode.com/2021/day/5

import Foundation

func readInput(from path: String) throws -> [String] {
    let url = URL(fileURLWithPath: path)
    let contents = try String(contentsOf: url, encoding: .utf8)
    return contents.split(separator: "\n").compactMap(String.init)
}
let input = try readInput(from: "input/day-05.txt")

struct Point {
    let x, y: Int
}

// MARK: - Part One
print("--- Day 5: Hydrothermal Venture ---")

private func overlaps(from input: [String], recognizeDiagonals: Bool = false) -> Int {
    var overlaps = 0
    var vents = [[Int]](repeating: [Int](repeating: 0, count: 1000), count: 1000)

    input.forEach { line in
        let points = line.split(separator: " ").map {
            $0.split(separator: ",").compactMap { Int(String($0)) }
        }.compactMap { $0.isEmpty ? nil : Point(x: $0[0], y: $0[1]) }
        guard let a = points.first, let b = points.last else { return }
        // vertical
        if a.x == b.x {
            (min(a.y, b.y)...max(a.y, b.y)).forEach { index in
                vents[a.x][index] += 1
                if vents[a.x][index] == 2 { overlaps += 1 }
            }
        }
        // horizontal 
        if a.y == b.y {
            (min(a.x, b.x)...max(a.x, b.x)).forEach { index in
                vents[index][a.y] += 1
                if vents[index][a.y] == 2 { overlaps += 1 }
            }
        }
        guard recognizeDiagonals else { return }
        // diagonal 
        if abs(a.x - b.x) == abs(a.y - b.y) {
            (0...abs(a.x - b.x)).forEach { offset in
                let offsetX = a.x < b.x ? offset : -offset
                let offsetY = a.y < b.y ? offset : -offset
                vents[a.x + offsetX][a.y + offsetY] += 1
                if vents[a.x + offsetX][a.y + offsetY] == 2 { overlaps += 1 }
            }
        }
    }

    return overlaps
}

print("Solution:", overlaps(from: input))
// Solution: 8060

// MARK: - Part Two
print("--- Part Two ---")

print("Solution:", overlaps(from: input, recognizeDiagonals: true))
// Solution: 21577
