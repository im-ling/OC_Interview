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
        setupScanAnimationView()
        setupBtns()
        NotificationCenter.default.addObserver(self, selector: #selector(startScanAnimation), name: UIApplication.didBecomeActiveNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(startScanAnimation), name: UIApplication.willEnterForegroundNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(startScanAnimation), name: .NSExtensionHostDidBecomeActive, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(endScanAnimation), name: .NSExtensionHostDidEnterBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(endScanAnimation), name: UIApplication.willResignActiveNotification, object: nil)

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupBtns() -> Void {
        
        let interval = 30.0
        let height = view.bounds.size.height - iconWidth - 80
                
        let btn = generateBtn(imageName: "flash_light")
        view.addSubview(btn)
        btn.frame = CGRect(x: interval, y: height, width: iconWidth, height: iconWidth)
        btn.addTarget(self, action: #selector(toggleFlash), for: UIControl.Event.touchUpInside)
    
        let photosBtn = generateBtn(imageName: "photos")
        view.addSubview(photosBtn)
        photosBtn.frame = CGRect(x: view.bounds.size.width - interval - iconWidth, y: height, width: iconWidth, height: iconWidth)
        photosBtn.addTarget(self, action: #selector(selectImageFromPhotos), for: UIControl.Event.touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.close, target: self , action: #selector(back))
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
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        startScanAnimation()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
        
        endScanAnimation()
    }
    
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
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
    
    
    // MARK: scan animation
    lazy var scanbgView: UIView = {
        var view = UIView.init()
        return view
    }()
    
    lazy var shapeLayerBgView: UIView = {
        var view = UIView.init()
        view.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        return view
    }()
    
    lazy var greenLineView: UIView = {
        var view = UIView.init()
        view.backgroundColor = UIColor.systemGreen
        view.alpha = 0.5
        view.isHidden = true
        return view
    }()
    
    lazy var shapeLayer: CAShapeLayer = {
        var shape = CAShapeLayer.init()
        return shape
    }()

    func setupScanAnimationView() -> Void {
        view.addSubview(scanbgView)
        scanbgView.frame = view.frame

        scanbgView.addSubview(shapeLayerBgView)
        shapeLayerBgView.frame = scanbgView.bounds
    }
    
    @objc func startScanAnimation() -> Void {
        let width = view.bounds.size.width * 0.8
        let x_offset = (view.bounds.size.width - width) * 0.5
        let y_offset = view.bounds.size.height * 0.5 - width * 0.5;

        let overlayPath = UIBezierPath.init(rect: scanbgView.bounds)
        let transparentRect = CGRect(x: x_offset, y: y_offset, width: width, height: width)
        let transparentPath = UIBezierPath.init(rect: transparentRect).reversing()
        overlayPath.append(transparentPath)
        shapeLayer.path = overlayPath.cgPath
        shapeLayerBgView.layer.mask = shapeLayer

        
        let green_line_width = width * 0.8
        let green_line_x_offset = (view.bounds.size.width - green_line_width) * 0.5
        let green_line_y_offset = view.bounds.size.height * 0.5 - width * 0.5 + (width - green_line_width) * 0.5;
        let green_line_height = green_line_width * 0.006
        let green_line_end_y = view.bounds.size.height - green_line_y_offset;


        greenLineView.frame = CGRect(x: green_line_x_offset, y: green_line_y_offset, width: green_line_width, height: green_line_height)
        scanbgView.addSubview(greenLineView)
        greenLineView.isHidden = false
        
        UIView.animate(withDuration: 3, delay: 0, options: .repeat) {
            self.greenLineView.center.y = green_line_end_y;
        }completion: { result in
        };
        
        
    }
    
    @objc func endScanAnimation() -> Void {
        scanbgView.layer.removeAllAnimations()
        greenLineView.isHidden = true
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
