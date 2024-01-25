//
//  ScannerViewController.swift
//  Grocer
//
//  Created by Ahmed Yamany on 20/01/2024.
//

import AVFoundation
import UIKit

protocol BarCodeScannerDelegate {
    func scanned(_ barcode: String)
}

class BarCodeScannerViewController: UIViewController {
    
    let delegate: BarCodeScannerDelegate
    let router: Router
    
    private lazy var scanner = CodeScanner(viewController: self, metadataObjectTypes: [.ean8, .ean13])
    
    init(router: Router, delegate: BarCodeScannerDelegate) {
        self.router = router
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .grBackground
        scanner.delegate = self
        scanner.checkCameraPermissions()
    }
   
}

extension BarCodeScannerViewController: CodeScannerDelegate {
    func scanned(_ code: String) {
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        delegate.scanned(code)
        router.dismiss()
    }
}
