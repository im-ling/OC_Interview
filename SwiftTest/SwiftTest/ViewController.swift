//
//  ViewController.swift
//  SwiftTest
//
//  Created by ling on 2022/11/11.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        view.addSubview(generateBtn)
        generateBtn.frame = CGRect(x: 0, y: view.frame.height * 0.5 - 100, width: 200, height: 50)
        generateBtn.center.x = view.center.x
        
        view.addSubview(scanBtn)
        scanBtn.frame = CGRect(x: 0, y: view.frame.height * 0.5 + 100, width: 200, height: 50)
        scanBtn.center.x = view.center.x
    }
    
    @objc func goGenerateQRCodeVc(){
        let vc = GenerateQRCodeViewController.init()
        vc.QRCodeString = "https://cn.bing.com/"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func goScanQRCodeVc(){
        let vc = ScanQRCodeViewController.init()
        self.navigationController?.pushViewController(vc, animated: true)
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
    
    lazy var resultLabel: UILabel = {
        var label: UILabel = UILabel()
        return label
    }()

}
