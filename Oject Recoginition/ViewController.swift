//
//  ViewController.swift
//  Oject Recoginition
//
//  Created by User on 28.01.18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCapturePhotoCaptureDelegate {

    @IBOutlet var previewView: UIView!
    @IBOutlet var predictionLabel: UILabel!
    
    var captureSession : AVCaptureSession!
    var cameraOutput :  AVCaptureOutput!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
    }
    
    func setupCamera(){
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        cameraOutput = AVCapturePhotoOutput()
        
        let device = AVCaptureDevice.default(for: AVMediaType.video)
        
        if let input = try? AVCaptureDeviceInput(device :device!){
            if(captureSession.canAddInput(input)){
                captureSession.addInput(input)
                
                
                if(captureSession.canAddOutput(cameraOutput)){
                    captureSession.addOutput(cameraOutput)
                }
                
                previewLayer = AVCaptureVideoPreviewLayer(session : captureSession)
                previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
                previewLayer.frame = previewView.bounds
                previewView.layer.addSublayer(previewLayer)
                captureSession.startRunning()
               
            }else{
                print (" could not add the input! ")
            }
        }else{
            print (" could not find an input! ")
        }
         self.launchAI()
    }
    
    func launchAI(){
        // CAPTURE Image from the video stream (camera)
        // we feed this image as the input of the ML Model
        // We capture the result and process it back to the user interface (Label)
        
        let settings = AVCapturePhotoSettings()
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first
        let previewFormat = [
            kCVPixelBufferPixelFormatTypeKey as String : previewPixelType,
            kCVPixelBufferWidthKey as String : 160 ,
            kCVPixelBufferHeightKey as String : 160
        ]
        settings.previewPhotoFormat = previewFormat
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }


}

