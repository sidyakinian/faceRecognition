//
//  ViewController.swift
//  SourceFiles
//
//  Created by sidyakinian on 05/08/2018.
//  Copyright © 2018 sidyakinian. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var toCompareButton: UIButton!
    @IBOutlet weak var compareToButton: UIButton!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var coefficient: UILabel!
    
    var isLeft = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
//    @IBAction func pickToCompareImageDidTap(_ sender: Any) {
//        let image = UIImagePickerController()
//        image.delegate = self
//
//        image.sourceType = .photoLibrary
//        image.allowsEditing = false
//        self.present(image, animated: true) {
//            self.isLeft = true
//        }
//    }
//
//    @IBAction func pickCompareToImageDidTap(_ sender: Any) {
//        let image = UIImagePickerController()
//        image.delegate = self
//
//        image.sourceType = .photoLibrary
//        image.allowsEditing = false
//        self.present(image, animated: true) {
//            self.isLeft = false
//        }
//    }
//
//
//    @IBAction func compareDidTap(_ sender: Any) {
//        let toCompareImage = toCompareButton.imageView?.image
//        let compareToImage = compareToButton.imageView?.image
//        let toCompareArray = FaceAPI.getArrayFromImage(toCompareImage!)
//        let compareToArray = FaceAPI.getArrayFromImage(compareToImage!)
//
//        let distance = FaceAPI.getDistanceBetweenArrays(toCompareArray, compareToArray)
//        if distance == 0 {
//            coefficient.text = "Нет коэффициента ало."
//            distanceLabel.text = "Нет лиц!"
//            distanceLabel.textColor = .black
//            return
//        }
//        let multiplied = distance * 100
//        coefficient.text = "Коэффициент: \(multiplied)"
//
//        switch multiplied {
//        case 0..<15:
//            distanceLabel.text = "Одинаковые!"
//            distanceLabel.textColor = UIColor(red: 43/255, green: 164/255, blue: 20/255, alpha: 1)
//        case 15..<35:
//            distanceLabel.text = "Похожи!"
//            distanceLabel.textColor = UIColor(red: 43/255, green: 164/255, blue: 20/255, alpha: 1)
//        case 35..<50:
//            distanceLabel.text = "Не похожи"
//            distanceLabel.textColor = UIColor(red: 254/255, green: 146/255, blue: 0/255, alpha: 1)
//        case 50..<100:
//            distanceLabel.text = "Разные"
//            distanceLabel.textColor = UIColor(red: 237/255, green: 24/255, blue: 12/255, alpha: 1)
//        default:
//            distanceLabel.text = "Хз, ошибка"
//            distanceLabel.textColor = .black
//        }
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        print(isLeft)
//        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            if isLeft {
//                toCompareButton.setImage(image, for: .normal)
//            } else {
//                compareToButton.setImage(image, for: .normal)
//            }
//        } else {
//            // Error message
//        }
//
//        self.dismiss(animated: true, completion: nil)
//    }
//}
//
//extension ViewController {
//
//    /// Speed tests
//    func createRandomArray() -> [Int] {
//        var array: [Int] = []
//        for _ in 1...128 {
//            let randomNumber = Int(arc4random_uniform(100000))
//            array.append(randomNumber)
//        }
//        return array
//    }
//
//    func compareRandomArrays(_ first: [Int], _ second: [Int]) -> Int {
//        var differenceArray: [Int] = []
//        for i in 0...127 {
//            differenceArray.append(first[i] - second[i])
//        }
//        let squaredArray = differenceArray.map { $0 * $0 }
//        let sum = squaredArray.reduce(0) { $0 + $1 }
//        return sum
//    }
//
//    func doSingleCheck() {
//        var hugeArray: [[Int]] = []
//        for _ in 1...10000 {
//            let randomArray = createRandomArray()
//            hugeArray.append(randomArray)
//        }
//        let checkerArray = createRandomArray()
//
//        var results: [Int] = []
//        for i in 0...9999 {
//            let result = compareRandomArrays(checkerArray, hugeArray[i])
//            results.append(result)
//        }
//        
//        if let min = results.min() {
//            print(min)
//        }
//    }
//    /// End speed tests
}

