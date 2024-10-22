//
//  ScanView.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 9/14/19.
//  Copyright © 2019 Hoàng Sơn Tùng. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import Vision
import JGProgressHUD

public protocol ScanViewDelegate {
    func ScanResult(ScanValue: String)
}

class ScanView: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    var cameraPreview: UIView = UIView()
    var captureSession: AVCaptureSession?
    var previewLayer: AVCaptureVideoPreviewLayer?
    var delegate: ScanViewDelegate?
    var deinitVisionFramework = false
    let hud = JGProgressHUD(style: .dark)
    
    private let visionQueue = DispatchQueue(label: "codes.megatunger qr.code.scanning")
    
    override func viewWillLayoutSubviews() {
        let closeBtn = UIButton.init(type: .custom)
        closeBtn.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        closeBtn.setTitle(" Đóng ", for: .normal)
        closeBtn.setTitleColor(.white, for: .normal)
        closeBtn.layer.borderWidth = 1
        closeBtn.contentEdgeInsets = UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5)
        closeBtn.layer.cornerRadius = CGFloat(Constant.cornerRadius)
        closeBtn.layer.borderColor = UIColor.systemRed.cgColor
        closeBtn.layer.backgroundColor = UIColor.systemRed.cgColor
        closeBtn.addTarget(self, action: #selector(selectorX), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeBtn)
        
        
        
        let doneBtn = UIButton.init(type: .custom)
        doneBtn.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        doneBtn.setTitle(" Xong ", for: .normal)
        doneBtn.setTitleColor(.white, for: .normal)
        doneBtn.layer.borderWidth = 1
        doneBtn.contentEdgeInsets = UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5)
        doneBtn.layer.cornerRadius = CGFloat(Constant.cornerRadius)
        doneBtn.layer.borderColor = UIColor.systemBlue.cgColor
        doneBtn.layer.backgroundColor = UIColor.systemBlue.cgColor
        doneBtn.addTarget(self, action: #selector(selectorY), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: doneBtn)
        
    }
    
    @objc func selectorX() {
        self.navigationController?.popViewController(animated: true)
        self.deinitVisionFramework = true
    }
    
    @objc func selectorY() {
        let resultScreenVC:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navigationresultScreen") as UIViewController
        self.present(resultScreenVC, animated: true, completion: nil)
        selectorX()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cameraPreview)
        cameraPreview.translatesAutoresizingMaskIntoConstraints = false
        cameraPreview.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        cameraPreview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        cameraPreview.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        cameraPreview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        cameraPreview.contentMode = .scaleAspectFit
     
        deinitVisionFramework = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // detect barcode in a image.
    lazy var barcodeDetection: VNDetectBarcodesRequest = {
        let barcodeDetectionRequest = VNDetectBarcodesRequest(completionHandler: self.BarCodeDetectionHandler)
        return barcodeDetectionRequest
    }()
    
    func BarCodeDetectionHandler(request: VNRequest, error: Error?) {
        guard let barcodeRequest = request as? VNDetectBarcodesRequest,
            let barcodeRequestResults = barcodeRequest.results as? [VNBarcodeObservation] else {
                return
                
        }
        
        DispatchQueue.main.async {
            for observation in barcodeRequestResults {
                guard let barcode = observation.payloadStringValue else{
                    return
                }
                self.handleResult(barcode: barcode)
            }
        }
    }
    
    
    func handleResult(barcode: String) {
        DispatchQueue.onceTime(executionToken: barcode) {
            self.delegate?.ScanResult(ScanValue: barcode)
        }
    }
    
    var triggered = false
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if !triggered {
            setupCameraSession()
        }
        triggered = true
        
    }
    
    func setupCameraSession() {
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSession.Preset.high
        
        
        do {
            let device = AVCaptureDevice.default(for: AVMediaType.video)
            let input = try AVCaptureDeviceInput(device: device!)
            if(device!.isFocusModeSupported(.continuousAutoFocus)) {
                try! device!.lockForConfiguration()
                device?.focusMode = .continuousAutoFocus
                device?.unlockForConfiguration()
                if((device?.isExposureModeSupported(AVCaptureDevice.ExposureMode.continuousAutoExposure))!){
                    try! device!.lockForConfiguration()
                    device?.exposureMode = AVCaptureDevice.ExposureMode.continuousAutoExposure
                    device?.unlockForConfiguration()
                }
                
                if((device?.isSmoothAutoFocusSupported)!){
                    try! device!.lockForConfiguration()
                    device?.isSmoothAutoFocusEnabled = true
                    device?.unlockForConfiguration()
                }
                
            }
            captureSession.addInput(input)
        } catch {
            print("Can't access camera")
            return
        }
        
        // To display camera preview
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        let viewLayer = cameraPreview.layer
        previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer?.frame = cameraPreview.bounds
        
        viewLayer.addSublayer(previewLayer!)
        
        let output = AVCaptureVideoDataOutput()
        
        if captureSession.canAddOutput(output) {
            captureSession.addOutput(output)
            let queue = DispatchQueue(label: "Constant.videoDataOutputQueueLabel")
            output.alwaysDiscardsLateVideoFrames = true
            output.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as String): Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)]
            output.setSampleBufferDelegate(self, queue: queue)
        }
        
        
        captureSession.startRunning()
        
    }
    
    
    
    func stopReading() {
        captureSession?.stopRunning()
        captureSession = nil
        previewLayer?.removeFromSuperlayer()
    }
    
    
    
    func captureOutput(_ output: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        visionQueue.async {
            do {
                self.handleBuffer(buffer: sampleBuffer)
            }
        }
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if !deinitVisionFramework {
            self.handleBuffer(buffer: sampleBuffer)
        }
    }
    
    
    
    func handleBuffer(buffer: CMSampleBuffer) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(buffer) else{
            return
        }
        
        //let Handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [VNImageOption: Any]())
        
        let Handler = VNSequenceRequestHandler()
        do {
            try Handler.perform([barcodeDetection], on: pixelBuffer)
        } catch {
            print(error as Any)
        }
    }
    
    
    deinit {
    }
    
    func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }
    
    
    func toggleTorch(on: Bool) {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video)
            else {return}
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                
                if on == true {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }
                
                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
    
    
    public func turnFlashOn(){
        toggleTorch(on: true)
    }
    
    
    public func turnFlashOff(){
        toggleTorch(on: false)
    }
    
}



extension DispatchQueue {
    public static var tokens: [String] = [] // static, so tokens are cached
    class func onceTime(executionToken: String, _ closure: () -> Void) {
        // objc_sync_enter/objc_sync_exit is a locking mechanism
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        if tokens.contains(executionToken) {return}
        tokens.append(executionToken)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            tokens.removeAll()
        }
        closure()
    }
}
