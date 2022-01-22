//
//  CameraPredictionView.swift
//  AllShortenedThings
//
//  Created by Hasan Dag on 28.12.2021.
//

import UIKit
import AVFoundation
import Vision

final class CameraPredictionView: UIView {
    
    lazy var previewView : UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .cyan
        return view
    }()
    
    lazy var predictLbl : UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.backgroundColor = .white
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        label.text = "..."
        return label
    }()
    var capture : AVCaptureSession? // Session for capture coordinates of input (video screen) or objects
    var cameraOutput : AVCapturePhotoOutput?
    var cameraLayer : AVCaptureVideoPreviewLayer?
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        backgroundColor = .white
        configureUI()
    }
    
    fileprivate func configureUI(){
        addSubview(previewView)
        addSubview(predictLbl)
        
        previewView.snp.makeConstraints { (maker) in
            maker.top.leading.trailing.equalToSuperview()
            maker.height.equalToSuperview().multipliedBy(0.8)
        }
        
        predictLbl.snp.makeConstraints { (maker) in
            maker.top.equalTo(previewView.snp.bottom)
            maker.leading.trailing.bottom.equalToSuperview()
            maker.centerX.equalToSuperview()
        }
        
        
        initializeCamera()
    }
    
    func initializeCamera() {
        capture = AVCaptureSession()
        capture?.sessionPreset = .photo
        cameraOutput = AVCapturePhotoOutput()
        
        let device = AVCaptureDevice.default(for: .video)
        
        guard let input = try? AVCaptureDeviceInput(device: device!) else {return}
        
        if capture?.canAddInput(input) == true {
            capture?.addInput(input)
            
            if capture?.canAddOutput(cameraOutput!) == true {
                capture?.addOutput(cameraOutput!)
            }
            
            cameraLayer = AVCaptureVideoPreviewLayer(session: capture!)
            cameraLayer?.videoGravity = .resizeAspectFill
            cameraLayer?.frame = previewView.bounds
            
            previewView.layer.addSublayer(cameraLayer!)
            
            capture?.startRunning()
        }
        
        else{
            print("camera input not found")
        }
        
        launcCameraSettings()
    }
    
    @objc func launcCameraSettings(){
        let settings = AVCapturePhotoSettings()
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [
            kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
            kCVPixelBufferWidthKey as String: 160,
            kCVPixelBufferHeightKey as String: 160
        ]
        settings.previewPhotoFormat = previewFormat
        
        cameraOutput?.capturePhoto(with: settings, delegate: self)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    fileprivate func recogniseImage(image:UIImage) {
        // if image can turn png as data
        guard let data = image.pngData() else{return}
        
        
        // file path
        let fileName = getDocumentsDirectory().appendingPathComponent("cameraImg.png")
        
        // write data to filepath as cameraImg.png
        try? data.write(to: fileName)
        
        // Configure MobileNet and convert request with Vision
        let model = try! VNCoreMLModel(for: MobileNetV2().model)
        let request = VNCoreMLRequest(model: model, completionHandler: predictionCompleted)
        let handler = VNImageRequestHandler(url: fileName)
        try! handler.perform([request])
        
    }
    
    func predictionCompleted(request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNClassificationObservation] else {
            fatalError("could not get any prediction output from ML model")
        }
        
        var bestPrediction = ""
        var confidence: VNConfidence = 0
        
        for classification in results {
            if classification.confidence > confidence {
                confidence = classification.confidence
                bestPrediction = classification.identifier
            }
        }
        predictLbl.text = predictLbl.text ?? "" + bestPrediction + "\n"
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.launcCameraSettings), userInfo: nil, repeats: false)
    }
    
}


extension CameraPredictionView : AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        }
        if let imageData = photo.fileDataRepresentation(), let image = UIImage(data: imageData) {
            self.recogniseImage(image: image)
        }

    }
}
