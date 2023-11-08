//
//  ViewController.swift
//  Davaleba_20
//
//  Created by Lika Nozadze on 11/8/23.
//
import UIKit

class ViewController: UIViewController {

    func generateTwoNumbers() -> (Double, Double) {
        let number1 = Double(Int.random(in: 20...50))
        let number2 = Double(Int.random(in: 20...50))
        return (number1, number2)
    }

    func calculateFactorial(of number: Double) -> Double {
        if number == 0 {
            return 1
        } else {
            return number * calculateFactorial(of: number - 1)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let (number1, number2) = generateTwoNumbers()
        print("Number 1: \(number1)")
        print("Number 2: \(number2)")

        let group = DispatchGroup()

        var isThread1Finished = false

        group.enter()
        let startTime1 = Date()

        DispatchQueue.global().async {
            let result1 = self.calculateFactorial(of: number1)
            let endTime1 = Date()
            let time1 = endTime1.timeIntervalSince(startTime1)
            print("Factorial of Number 1: \(result1) (Thread 1) - Time: \(time1) seconds")

            isThread1Finished = true
            group.leave()
        }

        group.enter()
        let startTime2 = Date()

        DispatchQueue.global().async {
            let result2 = self.calculateFactorial(of: number2)
            let endTime2 = Date()
            let time2 = endTime2.timeIntervalSince(startTime2)
            print("Factorial of Number 2: \(result2) (Thread 2) - Time: \(time2) seconds")
            group.leave()
        }

        group.notify(queue: .main) {
            if isThread1Finished {
                print("Thread 1 finished first!")
            } else {
                print("Thread 2 finished first!")
            }
        }
    }
}
