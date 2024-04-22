import Cocoa

protocol Building {
    var amountOfRooms: Int { get }
    var cost: Int { get set}
    var estateAgentName: String { get set }
    
    func printSalesSummary()
}

extension Building {
    func printSalesSummary() {
        print("""
-- Summary --
Amount of Rooms: \(amountOfRooms)
Cost: \(cost)
Estate Agent Selling the Building: \(estateAgentName)
""")
    }
}

struct House: Building {
    var amountOfRooms: Int
    
    var cost: Int
    
    var estateAgentName: String
}

struct Office: Building {
    var amountOfRooms: Int
    
    var cost: Int
    
    var estateAgentName: String
}

var house = House(amountOfRooms: 4, cost: 300_000, estateAgentName: "Phil Dunphy")
var office = Office(amountOfRooms: 20, cost: 750_000, estateAgentName: "Carol Stills")

house.printSalesSummary()
office.printSalesSummary()
