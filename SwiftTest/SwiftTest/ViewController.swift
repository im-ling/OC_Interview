//
//  ViewController.swift
//  SwiftTest
//
//  Created by ling on 2022/11/11.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        view.addSubview(inputWidget)
        inputWidget.frame = CGRect(x: 0, y: 150, width: view.frame.width - 100, height: 100)
        inputWidget.center.x = view.center.x
        
        view.addSubview(generateBtn)
        generateBtn.frame = CGRect(x: 0, y: view.frame.height * 0.5 - 100, width: 200, height: 50)
        generateBtn.center.x = view.center.x
        
        view.addSubview(scanBtn)
        scanBtn.frame = CGRect(x: 0, y: view.frame.height * 0.5 + 100, width: 200, height: 50)
        scanBtn.center.x = view.center.x
        
        view.addSubview(resultLabel)
        resultLabel.frame = CGRect(x: 0, y: view.frame.height * 0.5 + 100 + 100, width: 200, height: 50)
        resultLabel.center.x = view.center.x
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.all)
    }
    
    @objc func goGenerateQRCodeVc(){
        let vc = GenerateQRCodeViewController.init()
        let originalString = self.inputWidget.text ?? "www.baidu.com"
        let escapedString = originalString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        vc.QRCodeString = escapedString ?? "www.baidu.com"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func goScanQRCodeVc(){
        let vc = ScanQRCodeViewController.init()
        vc.completeBlock = {[weak self] result in
            self?.resultLabel.text = result.removingPercentEncoding
            self?.resultLabel.sizeToFit()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    // MARK: - LAZY LOAD
    lazy var generateBtn: UIButton = {
        var btn = UIButton.init()
        btn.setTitle("Generate QR code", for: UIControl.State.normal)
        btn.setTitleColor(UIColor.systemBlue, for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(goGenerateQRCodeVc), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    lazy var scanBtn: UIButton = {
        var btn = UIButton.init()
        btn.setTitle("Scan QR code", for: UIControl.State.normal)
        btn.setTitleColor(UIColor.systemBlue, for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(goScanQRCodeVc), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    lazy var inputWidget: UITextView = {
        var compopent = UITextView.init()
        compopent.backgroundColor = UIColor.lightGray
        compopent.layer.cornerRadius = 10
        compopent.layer.masksToBounds = true
        compopent.text = "www.baidu.com"
        compopent.delegate = self
        return compopent
    }()
    
    lazy var resultLabel: UILabel = {
        var label: UILabel = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
}
