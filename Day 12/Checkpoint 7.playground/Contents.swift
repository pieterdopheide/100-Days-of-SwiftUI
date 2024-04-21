import Cocoa

class Animal {
    let legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    init() {
        super.init(legs: 4)
    }
    
    func speak() {
        print("Woof!")
    }
}

class Corgi: Dog {
    override func speak() {
        print("Yap!")
    }
}

class Poodle: Dog {
    override func speak() {
        print("Bark!")
    }
}

class Cat: Animal {
    var isTame: Bool
    
    init(isTame: Bool) {
        self.isTame = isTame
        super.init(legs: 4)
    }
    
    func speak() {
        print("Meow!")
    }
}

class Persian: Cat {
    override init(isTame: Bool) {
        super.init(isTame: isTame)
    }
    
    override func speak() {
        print("Prrr.")
    }
}

class Lion: Cat {
    override init(isTame: Bool) {
        super.init(isTame: isTame)
    }
    
    override func speak() {
        print("Roar!")
    }
}

let corgi = Corgi()
let poodle = Poodle()

let persian = Persian(isTame: true)
let lion = Lion(isTame: false)

corgi.speak()
poodle.speak()

persian.speak()
lion.speak()
