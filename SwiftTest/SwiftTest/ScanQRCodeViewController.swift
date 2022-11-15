//
//  ScanQRCodeViewController.swift
//  SwiftTest
//
//  Created by ling on 2022/11/12.
//

import UIKit
import AVFoundation

let iconWidth = 50.0

class ScanQRCodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    var completeBlock:((_ result: String) -> Void) = { (result: String)  in
        print("Hey there, \(result).")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        setUpQRSession()
        setupBtns()
    }
    
    func setupBtns() -> Void {
                
        let btn = generateBtn(imageName: "flash_light")
        view.addSubview(btn)
        btn.frame = CGRect(x: 50, y: view.bounds.size.height * 0.7, width: iconWidth, height: iconWidth)
        btn.addTarget(self, action: #selector(toggleFlash), for: UIControl.Event.touchUpInside)
    
        let photosBtn = generateBtn(imageName: "photos")
        view.addSubview(photosBtn)
        photosBtn.frame = CGRect(x: view.bounds.size.width - 50.0 - iconWidth, y: view.bounds.size.height * 0.7, width: iconWidth, height: iconWidth)
        photosBtn.addTarget(self, action: #selector(selectImageFromPhotos), for: UIControl.Event.touchUpInside)
    }



    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    // MARK: - QR SCAN
    func setUpQRSession() {
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        captureSession.startRunning()
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }


    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }

//        dismiss(animated: true)
    }

    func found(code: String) {
        getQRCodeSuccess(message: code)
    }
    
    func getQRCodeSuccess(message: String) {
        completeBlock(message)
        self.navigationController?.popViewController(animated: true)
    }
    
    func getQRCodeFailed () {
        completeBlock("Couldn't recognize QR Code")
        self.navigationController?.popViewController(animated: true)
    }


    // MARK: - 手电筒
    @objc func toggleFlash() {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        guard device.hasTorch else { return }

        do {
            try device.lockForConfiguration()

            if (device.torchMode == AVCaptureDevice.TorchMode.on) {
                device.torchMode = AVCaptureDevice.TorchMode.off
            } else {
                do {
                    try device.setTorchModeOn(level: 1.0)
                } catch {
                    print(error)
                }
            }

            device.unlockForConfiguration()
        } catch {
            print(error)
        }
    }
    
    // MARK: - photos
    var imagePicker = UIImagePickerController()

    @objc func selectImageFromPhotos() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")

            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false

            present(imagePicker, animated: true, completion: nil)
        }

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("select image")
        self.dismiss(animated: true, completion: { () -> Void in

        })
        
        guard let image = info[.originalImage] as? UIImage else {
            getQRCodeFailed()
            return
//            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
//        pickImageCallback?(image)
        if let features = detectQRCode(image), !features.isEmpty{
            for case let row as CIQRCodeFeature in features{
                if row.messageString != nil {
                    getQRCodeSuccess(message: row.messageString!)
                    return
                }
            }
        }
        
        getQRCodeFailed()
    }
    
    
    func detectQRCode(_ image: UIImage?) -> [CIFeature]? {
        if let image = image, let ciImage = CIImage.init(image: image){
            var options: [String: Any]
            let context = CIContext()
            options = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
            let qrDetector = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: options)
            if ciImage.properties.keys.contains((kCGImagePropertyOrientation as String)){
                options = [CIDetectorImageOrientation: ciImage.properties[(kCGImagePropertyOrientation as String)] ?? 1]
            } else {
                options = [CIDetectorImageOrientation: 1]
            }
            let features = qrDetector?.features(in: ciImage, options: options)
            return features

        }
        return nil
    }
    
    // MARK: lazy load
    func generateBtn(imageName: String) -> UIButton {
        let edgeLen = 13.0
        let btn = UIButton.init()
        btn.backgroundColor = UIColor.init(white: 0.9, alpha: 0.4)
        btn.layer.cornerRadius = iconWidth * 0.5
        btn.layer.masksToBounds = true
        btn.setImage(UIImage.init(named: imageName), for: UIControl.State.normal)
        btn.imageEdgeInsets = UIEdgeInsets.init(top: edgeLen, left: edgeLen, bottom: edgeLen, right: edgeLen)
        return btn
    }

}
