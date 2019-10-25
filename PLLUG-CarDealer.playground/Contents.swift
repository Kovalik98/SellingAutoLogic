import UIKit

enum Colors: String {
    case  red = "Red"
    case  blue = "Blue"
    case  white = "White"
    case  black = "Black"
}

enum Engine {
    case petrol(Int)
    case electic(Int)
    case diesel(Int)
}

class Car: Hashable {
    
    let VIN = UUID().uuidString
    let manufacture: String
    let model: String
    let production: Int
    let color: Colors
    let engine: Engine
    init(manufacture: String, model: String, production: Int, color: Colors, engine: Engine ) {
        self.manufacture = manufacture
        self.model = model
        self.production = production
        self.color = color
        self.engine = engine
    }
    
    static func == (lhs: Car, rhs: Car) -> Bool {
        return lhs.VIN == rhs.VIN
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(VIN)

    }
}

class Human {
    let name: String
    let surname: String
    let age: Int
    let driverLicense: String?
    
    init(name: String, surname: String, age: Int, driverLicense: String?) {
        self.name = name
        self.surname = surname
        self.age = age
        self.driverLicense = driverLicense
    }
}
class CarDealer {
    private typealias HistoryRecord = (car: Car, human: Human, price: Int, date: Date)
    private var history = [HistoryRecord]()
    private var cars = Set<Car>()
    private var carPrices = [Car :Int]()
    func add(car:Car, price: Int){
        cars.insert(car)
        carPrices[car] = price
    }
    
    func sell(car: Car, to human: Human, price: Int) -> Bool{
        guard let minPrice = carPrices[car] ,price >= minPrice else {
            return false
        }
        cars.remove(car)
        history.append(HistoryRecord(car:car , human:human , price:price,date :Date()))
        return true
    }
    
    func avaliableCars(filter: (Car)-> Bool ) -> Set<Car> {
    return cars.filter(filter)
    }
    
}

let human1 = Human(name: "Name", surname: "Markiyanovich", age: 14, driverLicense: nil)
let car1 = Car(manufacture: "ZAZ", model: "Siemorka", production: 1997, color: .red, engine: .electic(15))

let car2 = Car(manufacture: "ZAZ", model: "Devyatka", production: 1999 , color: .red, engine: .petrol(3500))

let dealer = CarDealer()

dealer.add(car: car1, price: 890)
dealer.add(car: car2, price: 150000)

let filteredCars = dealer.avaliableCars { filteredCar -> Bool in
    if case let Engine.electic(_) = filteredCar.engine
    {
        return true
    }
    return false
    
}
print (filteredCars.map({ (car) -> String in
    return " \(car.manufacture) \(car.engine)"
}))

print( dealer.sell(car: car1, to: human1, price: 200000))


