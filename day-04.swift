// --- Day 4: Giant Squid ---
// https://adventofcode.com/2021/day/4

import Foundation

func readInput(from path: String) throws -> [String] {
    let url = URL(fileURLWithPath: path)
    let contents = try String(contentsOf: url, encoding: .utf8)
    return contents.split(separator: "\n").map(String.init)
}
let input = try readInput(from: "input/day-04.txt")

// MARK: - Part One
print("--- Day 4: Giant Squid ---")

extension Array where Element == [Int?] {
    var sum: Int { reduce(0) { $0 + $1.compactMap { $0 }.reduce(0, +) } }
}

private func bingo(from input: [String]) -> Int? {
    let turns = input.first?.split(separator: ",").compactMap { Int($0) } ?? []
    var boards: [[[Int?]]] = stride(from: 1, to: input.count - 1, by: 5).map { index in
		((index)...(index + 4)).map { row in
			input[row].split(separator: " ").compactMap { Int($0) }
		}
	}

    // insert >here it comes< meme
    for number in turns {
        for board in boards.indices {
            for row in boards[board].indices {
                for column in boards[board][row].indices {
                    guard boards[board][row][column] == number else { continue }
                    boards[board][row][column] = nil
                    guard
                        boards[board][row].compactMap({ $0 }).isEmpty
                        || (0...4).compactMap({ boards[board][$0][column] }).isEmpty
                    else { continue }
                    return Array(boards[board]).sum * number
                }
            }
        }
    }
    return nil
}

print("Solution:", bingo(from: input)!)
// Solution: 38594

// MARK: - Part Two
print("--- Part Two ---")

private func bingoLastWinner(from input: [String]) -> Int? {
    let turns = input.first?.split(separator: ",").compactMap { Int($0) } ?? []
    var boards: [[[Int?]]] = stride(from: 1, to: input.count - 1, by: 5).map { index in
		((index)...(index + 4)).map { row in
			input[row].split(separator: " ").compactMap { Int($0) }
		}
	}

    var winners = [Int]()

    // insert >here it comes< meme
    for number in turns {
        for board in boards.indices.reversed() {
            boardLoop: for row in boards[board].indices {
                for column in boards[board][row].indices {
                    guard boards[board][row][column] == number else { continue }
                    boards[board][row][column] = nil
                    guard
                        boards[board][row].compactMap({ $0 }).isEmpty
                        || (0...4).compactMap({ boards[board][$0][column] }).isEmpty
                    else { continue }
                    winners.append(Array(boards[board]).sum * number)
                    boards.remove(at: board)
                    break boardLoop
                }
            }
        }
    }
    return winners.last
}

print("Solution:", bingoLastWinner(from: input)!)
// Solution: 21184
