import Foundation
import AVFoundation
import UIKit


class CameraViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    // カメラやマイクの入出力を管理するオブジェクトを生成
    private let session = AVCaptureSession()
    var uid = String()
    
    var isbn = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera],
                                                                mediaType: .video,
                                                                position: .back)
        
        // ワイドアングルカメラ・ビデオ・背面カメラに該当するデバイスを取得
        let devices = discoverySession.devices
        
        //　該当するデバイスのうち最初に取得したものを利用する
        if let backCamera = devices.first {
            do {
                // QRコードの読み取りに背面カメラの映像を利用するための設定
                let deviceInput = try AVCaptureDeviceInput(device: backCamera)
                
                if self.session.canAddInput(deviceInput) {
                    self.session.addInput(deviceInput)
                    
                    // 背面カメラの映像からQRコードを検出するための設定
                    let metadataOutput = AVCaptureMetadataOutput()
                    
                    if self.session.canAddOutput(metadataOutput) {
                        self.session.addOutput(metadataOutput)
                        
                        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                        metadataOutput.metadataObjectTypes = [.qr, .ean8, .ean13]
                        
                        // 背面カメラの映像を画面に表示するためのレイヤーを生成
                        let previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
                        previewLayer.frame = self.view.bounds
                        previewLayer.videoGravity = .resizeAspectFill
                        self.view.layer.insertSublayer(previewLayer,at: 0)
                        
                        // 読み取り開始
                        
                        
                        
                        self.session.startRunning()
                    }
                }
            } catch {
                print("Error occured while creating video device input: \(error)")
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        for metadata in metadataObjects as! [AVMetadataMachineReadableCodeObject] {
            // QRコードのデータかどうかの確認
            
            //            if metadata.type != .ean8 || metadata.type != .ean13 { continue }
            
            // QRコードの内容が空かどうかの確認
            if metadata.stringValue == nil { continue }
            
            
            
            if let UrlStr = metadata.stringValue, let _ = URL(string: UrlStr) {
                
                isbn = UrlStr
                
                self.session.stopRunning()
                
                performSegue(withIdentifier: "toNext", sender: nil)
                
                
                break
            }
            else {
                print("incorrect url: \(String(describing: metadata.stringValue))")
            }
            
            
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNext" {
            let dest = segue.destination as! UsedAPIUIViewController
            dest.isbn = isbn
        }
    }
    
    
}
