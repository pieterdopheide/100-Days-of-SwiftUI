import Cocoa

enum SqrtError: Error {
    case outOfBounds
    case noRoot
}

func squareRoot(_ number: Int) throws -> Int {
    if number < 1 || number > 10_000 {
        throw SqrtError.outOfBounds
    }
    
    for i in 1...100 {
        if i * i == number {
            return i
        }
    }
    
    throw SqrtError.noRoot
}

do {
    let root = try squareRoot(25)
    print(root)
} catch {
    print(error)
}
