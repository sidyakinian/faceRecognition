//
//  FaceAPI.swift
//  SourceFiles
//
//  Created by sidyakinian on 06/08/2018.
//  Copyright © 2018 sidyakinian. All rights reserved.
//

import Foundation
import Vision

class FaceAPI {
    
    // Returns an array of 128 float numbers, describing a picture in a unique way.
    // Comes with an automatic getCroppedImage(image, precision) method.
    static func getArrayFromImage(_ image: CGImage) -> [Float] {
        if let croppedImage = getCroppedImage(image, precision: .low) {
            print("Wow, look, a face!")
            let myFloat = Functions().getImageDescriptor(croppedImage)
            return myFloat as NSArray as! [Float]
        } else {
            return [0.0]
        }
        
    }
    
    // Returns a float corresponding to how different two arrays are.
    static func getDistanceBetweenArrays(_ one: [Float], _ another: [Float]) -> Float {
        if one.count == 1 || another.count == 1 {
            return 100
        }
        var differenceArray: [Float] = []
        for i in 0...127 {
            differenceArray.append(one[i] - another[i])
        }
        let squaredArray = differenceArray.map { $0 * $0 }
        let sum = squaredArray.reduce(0) { $0 + $1 }
        return sum
    }
    
    // Crops an image to better show the face.
    // Set precision between 0 and 0.5 for less or more borders around the face respectively.
    // Comes with an automatic resizeImage(image, size) method with scales low resolution images 5x.
    static func getCroppedImage(_ cgImage: CGImage, precision: Precision) -> UIImage? {
        
        var resultImage: UIImage?
        let precisionPoint = precision.rawValue
        
        let request = VNDetectFaceRectanglesRequest { (request, error) in
            
            if let error = error {
                print("Failed with error: ", error.localizedDescription)
                return
            }
            
            request.results?.forEach({ (result) in
                
                guard let faceObservation = result as? VNFaceObservation else { return }
                
                let width = CGFloat((cgImage.width)) * faceObservation.boundingBox.width
                let height = CGFloat((cgImage.height)) * faceObservation.boundingBox.height
                let x = CGFloat((cgImage.width)) * faceObservation.boundingBox.origin.x
                let y = CGFloat((cgImage.height)) * (1 - faceObservation.boundingBox.origin.y) - height
                
                let rectangle = CGRect(x: x - precisionPoint * width, y: y - precisionPoint * height, width: width * (1 + 2 * precisionPoint), height: height * (1 + 2 * precisionPoint))
                
                let croppedImage = cgImage.cropping(to: rectangle)
                resultImage = UIImage(cgImage: croppedImage!)
            })
        }
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        do {
            try handler.perform([request])
        } catch let requestError {
            print("Error", requestError)
        }

//        let resizedWidth = resultImage!.size.width * 5
//        let resizedHeight = resultImage!.size.width * 5
//        let size = CGSize(width: resizedWidth, height: resizedHeight)
//        let resizedImage = resizeImage(image: resultImage!, targetSize: size)
        
        return resultImage
    }
    
    enum Precision: CGFloat {
        case low = 0.1
        case average = 0.2
        case high = 0.3
        case veryHigh = 0.4
    }
}
