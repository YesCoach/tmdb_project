import UIKit

var greeting = "Hello, playground"

var apple: [Int] = [] {
    willSet(newValue) {
        print(newValue)
    }
}

apple.append(3)
apple.append(4)
apple.append(5)
