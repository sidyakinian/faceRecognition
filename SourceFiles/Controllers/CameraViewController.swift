//
//  CameraViewController.swift
//  SourceFiles
//
//  Created by sidyakinian on 19/08/2018.
//  Copyright © 2018 sidyakinian. All rights reserved.
//

import UIKit
import AVKit
import Vision

var capturedFramesNumber = 0
var iSidentificationRunning = false

class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .hd4K3840x2160
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)
        
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.insertSublayer(previewLayer, at: 0)
        previewLayer.frame = view.frame
        previewLayer.videoGravity = .resizeAspectFill
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
        
        previewLayer.connection?.videoOrientation = .portrait
        
        label.text = "Show me a pic!"
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        let context = CIContext()
        let intermediateImage = context.createCGImage(ciImage, from: ciImage.extent)
        let uiImage = UIImage(cgImage: intermediateImage!)
        let rotatedImage = imageRotatedByDegrees(oldImage: uiImage, deg: 90)
        let cgImage = rotatedImage.cgImage
        
        print("Output captured! \(capturedFramesNumber)")
        capturedFramesNumber += 1
        
        let array = FaceAPI.getArrayFromImage(cgImage!)
        
        if let identified = identify(array, from: people, discardValue: 0.4) {
            DispatchQueue.main.async {
                self.label.text = identified.link
            }
            
            print("Identified!")
        } else {
            print(array)
            if array.count > 20 {
                DispatchQueue.main.async {
                    
                    self.label.text = "Unknown"
                    
                    let alert = UIAlertController(title: "New person! What's his/her name?", message: nil, preferredStyle: .alert)
                    
                    alert.addTextField(configurationHandler: { textField in
                        textField.placeholder = "Name..."
                    })
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        
                        if let name = alert.textFields?.first?.text {
                            people.append(Person(identifier: array, link: name))
                        }
                    }))
                    
                    self.present(alert, animated: true)
                    
                }
            }
            
            print("Unknown")
        }
        
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func identify(_ array: [Float], from set: [Person], discardValue: Float) -> Person? {
        print("Identify function called!")
        var closestPerson = set[0]
        var closestDistance = FaceAPI.getDistanceBetweenArrays(array, closestPerson.identifier)
        for person in set {
            let distance = FaceAPI.getDistanceBetweenArrays(array, person.identifier)
            if distance < closestDistance {
                closestPerson = person
                closestDistance = distance
            }
        }
        if closestDistance < 0.4 {
            return closestPerson
        } else {
            return nil
        }
    }

}
