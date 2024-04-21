import Cocoa

struct Car {
    let model: String
    let numberOfSeats: Int
    private(set) var gear = 1
    
    init(model: String, numberOfSeats: Int) {
        self.model = model
        self.numberOfSeats = numberOfSeats
    }
    
    mutating func shiftGearsUp() {
        if self.gear < 10 {
            self.gear += 1
        }
    }
    
    mutating func shiftGearsDown() {
        if self.gear > 1 {
            self.gear -= 1
        }
    }
}

var deLorean = Car(model: "1981 DeLorean DMC-12", numberOfSeats: 2)
print("Current gear: \(deLorean.gear)")
deLorean.shiftGearsUp()
print("Current gear is now: \(deLorean.gear)")
deLorean.shiftGearsDown()
print("Current gear is now: \(deLorean.gear)")
deLorean.shiftGearsDown()
print("Current gear is now: \(deLorean.gear)")
