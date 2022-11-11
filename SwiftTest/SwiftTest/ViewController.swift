//
//  ViewController.swift
//  SwiftTest
//
//  Created by ling on 2022/11/11.
//

import UIKit

class ViewController: UIViewController {

    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        if let QRFilter = CIFilter(name: "CIQRCodeGenerator") {
            QRFilter.setValue(data, forKey: "inputMessage")
            guard let QRImage = QRFilter.outputImage else {return nil}
            return UIImage(ciImage: QRImage)
        }
        return nil
    }
    
    var QRCodeImageView = UIImageView.init()
    
    
    func testShowQRCode() {
        let testUrl = "https://www.baidu.com/"
        if let image = generateQRCode(from: testUrl) {
            view.addSubview(QRCodeImageView)
            let sideLength = UIScreen.main.bounds.size.width
            QRCodeImageView.image = image
            QRCodeImageView.bounds = CGRect(x: 0, y: 0, width: sideLength, height: sideLength)
            QRCodeImageView.center = view.center
            
            // 防止放大后不清晰
            QRCodeImageView.layer.magnificationFilter = CALayerContentsFilter.nearest
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        testShowQRCode()
    }


}
