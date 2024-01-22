//
//  BarCodeScanner.swift
//  Grocer
//
//  Created by Ahmed Yamany on 22/01/2024.
//

import UIKit
import AVFoundation

extension LoggingCategories {
    public var codeScanner: String { "Code Scanner" }
}

protocol CodeScannerDelegate {
    func scanned(_ code: String)
}

public final class CodeScanner: NSObject {
    // MARK: Properties
    //
    var captureSession: AVCaptureSession?
    let previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer()
    var delegate: CodeScannerDelegate?

    let viewController: UIViewController
    let metadataObjectTypes: [AVMetadataObject.ObjectType]
    
    init(viewController: UIViewController, metadataObjectTypes: [AVMetadataObject.ObjectType]) {
        self.viewController = viewController
        self.metadataObjectTypes = metadataObjectTypes
    }
    
    // MARK: - Public Handlers
    //
    public func startRunning() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.captureSession?.startRunning()
        }
    }
    
    public func stopRunning() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.captureSession?.stopRunning()
        }
    }
    
    public func checkCameraPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .notDetermined: requestCameraPermissions()
            case .restricted:
                break
            case .denied:
                break
            case .authorized:
                setupCaptureSession()
            @unknown default:
                break
        }
    }
    
    // MARK: - Private Handlers
    //
    private func requestCameraPermissions() {
        AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
            guard granted else { return}
            self?.setupCaptureSession()
        }
    }
    
    private func setupCaptureSession() {
        let captureSession = AVCaptureSession()
        
        guard let deviceInput = createDeviceInput() else {
            Logger.log("failed to create device Input", category: \.codeScanner, level: .fault)
            return
        }
        
        guard captureSession.canAddInput(deviceInput) else {
            Logger.log("Failed to add device input to capture session", category: \.codeScanner, level: .fault)
            return
        }
        
        captureSession.addInput(deviceInput)
        
        let metaDataOutput = AVCaptureMetadataOutput()
        
        guard captureSession.canAddOutput(metaDataOutput) else {
            Logger.log("Failed to add metadata output to capture session", category: \.codeScanner, level: .fault)
            return
        }
        
        captureSession.addOutput(metaDataOutput)
        
        metaDataOutput.setMetadataObjectsDelegate(self, queue: .main)
        metaDataOutput.metadataObjectTypes = metadataObjectTypes
        
        self.captureSession = captureSession
        self.addPreviewLayer(to: captureSession)
        self.startRunning()
    }
    
    private func createDeviceInput() -> AVCaptureDeviceInput? {
        guard let device = AVCaptureDevice.default(for: .video) else {
            Logger.log("failed to get capture device", category: \.codeScanner, level: .fault)
            return nil
        }
        
        do {
            return try AVCaptureDeviceInput(device: device)
        } catch {
            Logger.log(error.localizedDescription, category: \.default, level: .fault)
        }
        
        return nil
    }
    
    private func addPreviewLayer(to session: AVCaptureSession) {
        removeExistingLayers()
        viewController.view.layer.addSublayer(previewLayer)
        previewLayer.frame = viewController.view.bounds
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.session = session
    }
    
    private func removeExistingLayers() {
        if let sublayers = self.viewController.view.layer.sublayers {
            for sublayer in sublayers {
                if sublayer.isKind(of: AVCaptureVideoPreviewLayer.self) {
                    sublayer.removeFromSuperlayer()
                }
            }
        }
    }
}

// MARK: - AVCaptureMetadataOutputObjectsDelegate
//
extension CodeScanner: AVCaptureMetadataOutputObjectsDelegate {
    
    public func metadataOutput( _ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject],
                                from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else {
                Logger.log("failed to wrap metadataObject", category: \.codeScanner, level: .fault)
                return
            }
            
            guard let code = readableObject.stringValue else {
                Logger.log("failed to get string value from metadataObject", category: \.codeScanner, level: .fault)
                return
            }
            
            delegate?.scanned(code)
            stopRunning()
        }
    }
}
