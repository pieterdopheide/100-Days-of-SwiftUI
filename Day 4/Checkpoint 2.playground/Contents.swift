import Cocoa

let strings = ["String 1", "String 2", "String 3", "String 3"]
print("The array contains \(strings.count) strings")
let uniqueItems = Set(strings)
print("The array contains \(uniqueItems.count) unique strings")
