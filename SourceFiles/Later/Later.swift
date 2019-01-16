//
//  Later.swift
//  SourceFiles
//
//  Created by sidyakinian on 21/08/2018.
//  Copyright © 2018 sidyakinian. All rights reserved.
//

import Foundation

//    let trackingRequest = VNDetectFaceRectanglesRequest { (request, error) in
//
//        if let error = error {
//            print("Failed to detect faces: ", error)
//            return
//        }
//
//        faceObservations = []
//        boundingBoxes = []
//
//        request.results?.forEach({ (res) in
//
//            DispatchQueue.main.async {
//                guard let faceObservation = res as? VNFaceObservation else { return }
//
//                print("x: \(faceObservation.boundingBox.origin.x)")
//                print("y: \(faceObservation.boundingBox.origin.y)")
//                print("width: \(faceObservation.boundingBox.width)")
//                print("height: \(faceObservation.boundingBox.height)")
//
//                drawRectangle(faceObservation.boundingBox, faceObservation: faceObservation)
//
//                faceObservations.append(faceObservation)
//                boundingBoxes.append(faceObservation.boundingBox)
//
//                print("Tracking request done")
//            }
//        })
//    }

//    func testRectangle() {
//        let redView = UIView()
//        redView.backgroundColor = .red
//        redView.alpha = 0.4
//        redView.frame = CGRect(x: 34, y: 25, width: 123, height: 346)
//        self.view.addSubview(redView)
//        print("Test rectangle!")
//    }

//    func drawRectangle(_ box: CGRect, faceObservation: VNFaceObservation) {
//        let scaledHeight = view.frame.width * 3840 / 2160
//
//        let x = self.view.frame.width * faceObservation.boundingBox.origin.x
//        let height = scaledHeight * faceObservation.boundingBox.height
//        let y = scaledHeight * (1 -  faceObservation.boundingBox.origin.y) - height
//        let width = self.view.frame.width * faceObservation.boundingBox.width
//
//        let redView = UIView()
//        redView.backgroundColor = .red
//        redView.alpha = 0.4
//        redView.frame = CGRect(x: x, y: y, width: width, height: height)
//        self.view.addSubview(redView)
//        print("Drew rectangle!")
//    }

//        print("CGImage, width: \(cgImage?.width), height: \(cgImage?.height)")

//        DispatchQueue.global(qos: .background).async {
//            let handler = VNImageRequestHandler(cgImage: cgImage!, options: [:])
//            do {
//                try handler.perform([self.trackingRequest])
//            } catch let reqErr {
//                print("Failed to perform request:", reqErr)
//            }
//        }

//        DispatchQueue.main.async {
//            for (i, box) in boundingBoxes.enumerated() {
//                self.drawRectangle(box, faceObservation: faceObservations[i])
//            }
//        }

//        if !iSidentificationRunning {
//            iSidentificationRunning = true
//
//            let resultArray = FaceAPI.getArrayFromImage(cgImage!)
//            if resultArray.count > 62 {
//                DispatchQueue.main.async {
//                    let number = resultArray[62]
//                    print(number)
//                }
//            }
//
//            if lastArray.count == 128 {
//                let distance = FaceAPI.getDistanceBetweenArrays(lastArray, resultArray)
//                if distance > 0.5 {
//                    DispatchQueue.main.async {
//                        print("New guy!")
//                    }
//                }
//            } else {
//                print("Not 128")
//            }
//
//            lastArray = resultArray
//
//            iSidentificationRunning = false
//        }
