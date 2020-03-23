//
//  ViewController.swift
//  VirtualDrapingSwift
//
//  Created by Sandeep Ahuja on 23/03/20.
//  Copyright © 2020 Sapient. All rights reserved.
//

import UIKit
import AVFoundation;

class ViewController: UIViewController {
    var captureSession: AVCaptureSession?
    var captureVideoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCapture()
    }

    private func initCapture() {
        
        guard let inputDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .front) else {
            return
        }
        do {            
            let captureInput = try AVCaptureDeviceInput(device: inputDevice)
            let captureOutput = AVCaptureVideoDataOutput.init()
            captureOutput.setSampleBufferDelegate(self, queue: DispatchQueue.main)
            let key = kCVPixelBufferPixelFormatTypeKey as String;
            let value = NSNumber(value: kCVPixelFormatType_32BGRA)
            captureOutput.videoSettings = [key as String: value]
            self.captureSession = AVCaptureSession.init()
            self.captureSession!.sessionPreset = AVCaptureSession.Preset.medium
            if self.captureSession!.canAddInput(captureInput) {
                self.captureSession!.addInput(captureInput)
            }
            if self.captureSession!.canAddOutput(captureOutput) {
                self.captureSession!.addOutput(captureOutput)
            }
            captureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession!)
            
            self.captureVideoPreviewLayer?.frame = self.view.bounds;
            self.captureVideoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill;
            self.view.layer.addSublayer(self.captureVideoPreviewLayer!)
            self.captureSession?.startRunning()
        } catch(let error) {
            print(error.localizedDescription)
        }
    }
}

extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    
}

