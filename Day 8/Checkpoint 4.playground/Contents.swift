import Cocoa

enum SqrtError: Error {
    case OutOfBounds
    case NoRoot
}

func squareRoot(_ number: Int) throws -> Int {
    if number < 1 || number > 10_000 {
        throw SqrtError.OutOfBounds
    }
    
    if number == 0 || number == 1 {
        return number
    }
    
    var i = 1
    var result = 1
    
    while result <= number {
        i += 1
        result = i * i
    }
    
    if (i - 1) * (i - 1) != number {
        throw SqrtError.NoRoot
    }
    
    return i - 1
}

do {
    let root = try squareRoot(25)
    print(root)
} catch {
    print(error)
}
