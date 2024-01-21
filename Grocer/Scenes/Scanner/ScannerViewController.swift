//
//  ScannerViewController.swift
//  Grocer
//
//  Created by Ahmed Yamany on 20/01/2024.
//

import AVFoundation
import UIKit
import MakeConstraints

protocol Delegate {
    func updateLabel(with title: String)
}

class Scanner: NSObject {
    private var viewController: UIViewController
    private var captureSession: AVCaptureSession
    private var codeOutputHandler: (_ code: String) -> Void
    
    init(viewController: UIViewController, captureSession: AVCaptureSession, codeOutputHandler: @escaping (_: String) -> Void) {
        self.viewController = viewController
        self.captureSession = captureSession
        self.codeOutputHandler = codeOutputHandler
    }
    
//    private func createCaptureSession() -> AVCaptureSession? {
//        let captureSession = AVCaptureSession()
//        
//    }
    
}

class BarCodeScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var session: AVCaptureSession?
    let output = AVCapturePhotoOutput()
    let previewLayer = AVCaptureVideoPreviewLayer()
    
    private let shutterButton: UIButton = {
        let button = UIButton()
        button.equalSizeConstraints(100)
        button.layer.cornerRadius = 50
        button.layer.borderWidth = 10
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    var delegate: Delegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.layer.addSublayer(previewLayer)
        view.addSubview(shutterButton)
        
        checkCameraPermissions()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.bounds
        shutterButton.centerXInSuperview()
        shutterButton.makeConstraints(bottomAnchor: view.bottomAnchor,
                                      padding: UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0))
    }
    
    private func checkCameraPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard granted else { return}
                DispatchQueue.main.async {
                    self?.setupCamera()
                    print("Not authorized")
                }
            }
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
                print("authorized")
            setupCamera()
        @unknown default:
            break
        }
    }
    
    private func setupCamera() {
        let session = AVCaptureSession()
        if let device = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                
                if session.canAddOutput(output) {
                    session.addOutput(output)
                }
                
                let metadataOutput = AVCaptureMetadataOutput()
                if session.canAddOutput(metadataOutput) {
                    session.addOutput(metadataOutput)
                    metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                    metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417]
                }
                
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
                Task(priority: .background) {
                    session.startRunning()
                }
                self.session = session
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func metadataOutput(
        _ output: AVCaptureMetadataOutput,
        didOutput metadataObjects: [AVMetadataObject],
        from connection: AVCaptureConnection
    ) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            print(stringValue)
            self.delegate?.updateLabel(with: stringValue)
            dismiss(animated: true)
            
        }
    }
}
