import Cocoa

func returnRandom(integers: [Int]?) -> Int {
    integers?.randomElement() ?? Int.random(in: 1...100)
}

print(returnRandom(integers: [52, 12, 21, 5, 14]))
print(returnRandom(integers: nil))
