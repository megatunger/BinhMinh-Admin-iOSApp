//
//  step_2_HomeworkExceriseViewController.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 3/25/20.
//  Copyright © 2020 Hoàng Sơn Tùng. All rights reserved.
//

import UIKit
import MercariQRScanner
class step_2_HomeworkExceriseViewController: UIViewController {
    var questionResponse = QuestionResponse()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let qrScannerView = QRScannerView(frame: view.bounds)
        view.addSubview(qrScannerView)
        qrScannerView.configure(delegate: self)
        qrScannerView.startRunning()
        // Do any additional setup after loading the view.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "foundQuestion" {
            if let destinationVC = segue.destination as? step_3_HomeworkExceriseViewController {
                destinationVC.questionResponse = questionResponse
            }
        }
    }
}
extension step_2_HomeworkExceriseViewController: QRScannerViewDelegate {
    func qrScannerView(_ qrScannerView: QRScannerView, didFailure error: QRScannerError) {
        print(error)
    }

    func qrScannerView(_ qrScannerView: QRScannerView, didSuccess code: String) {
        Constant.hud.show(in: self.view)
        Constant.APIManager.getQuestion(question_hash_id: code, completion: {
            (data,error) in
            switch data?.status {
                case "success":
                    Constant.hud.dismiss()
                    qrScannerView.stopRunning()
                    self.questionResponse = data ?? QuestionResponse()
                    self.performSegue(withIdentifier: "foundQuestion", sender: self)
                    break
                case "failed":
                    let alert = UIAlertController(title: "Có lỗi xảy ra", message: data?.message, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in
                        qrScannerView.rescan()
                    }))
                    self.present(alert, animated: true, completion: nil)
                    break
                case .none:
                    break
                case .some(_):
                    break
                }
        })
    }
}
