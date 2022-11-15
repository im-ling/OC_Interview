//
//  GenerateQRCodeViewController.swift
//  SwiftTest
//
//  Created by ling on 2022/11/12.
//

import UIKit

class GenerateQRCodeViewController: UIViewController {
    
    var QRCodeString = "https://www.baidu.com/"

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
        if let image = generateQRCode(from: QRCodeString) {
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
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        testShowQRCode()
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
