//
//  callSiblings+call.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 9/27/19.
//  Copyright © 2019 Hoàng Sơn Tùng. All rights reserved.
//

import Foundation
import UIKit
extension callSiblings {
    
    func showAlert(model: Student_Off) {
        let alertController = UIAlertController(title: "Gọi Điện Phụ Huynh", message: model.name, preferredStyle: .alert)
        
        let oneAction = UIAlertAction(title: "Mẹ: \(model.mother.name)", style: .default) { (_) in
            self.makePhoneCall(tel: model.mother.phone)
        }
        let twoAction = UIAlertAction(title: "Bố: \(model.father.name)", style: .default) { (_) in
            self.makePhoneCall(tel: model.father.phone)
        }
        
        let threeAction = UIAlertAction(title: "Học sinh", style: .default) { (_) in
            self.makePhoneCall(tel: model.phone)
        }
        let cancelAction = UIAlertAction(title: "Đóng", style: .cancel) { (_) in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(oneAction)
        alertController.addAction(twoAction)
        alertController.addAction(threeAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
    
    func makePhoneCall(tel: String) {
        if let url = URL(string: "tel://\(tel)"),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
