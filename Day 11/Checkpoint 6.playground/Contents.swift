import Cocoa

struct Car {
    let model: String
    let numberOfSeats: Int
    private(set) var gear = 1
    
    init(model: String, numberOfSeats: Int) {
        self.model = model
        self.numberOfSeats = numberOfSeats
    }
    
    mutating func shiftGears(to gear: Int) {
        if gear >= 1 && gear <= 10 {
            self.gear = gear
        }
    }
}

var deLorean = Car(model: "1981 DeLorean DMC-12", numberOfSeats: 2)
print("Current gear: \(deLorean.gear)")
deLorean.shiftGears(to: 2)
print("Current gear is now: \(deLorean.gear)")
