import Cocoa

let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

luckyNumbers.filter { n in
    !n.isMultiple(of: 2)
}
.sorted()
.map { n in
    if n.isMultiple(of: 7) {
        print("\(n) is a lucky number")
    } else {
        print("\(n) is not a lucky number")
    }
}
