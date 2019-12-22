//
//  rootScanView.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 9/14/19.
//  Copyright © 2019 Hoàng Sơn Tùng. All rights reserved.
//

import Foundation
import UIKit
import PanModal
import Kingfisher
import NotificationBannerSwift
class rootScanView: ScanView, ScanViewDelegate {

    let APIManager = BinhMinhAPIManager()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    func ScanResult(ScanValue: String) {

        let id = Int(ScanValue) ?? nil
        if !(id==nil) {
            APIManager.autoCheckIn(id: id!, completion: {(data, error) in
                if let error = error {
                    print(error)
                    return
                }
                var title: String?
                var subtitle: String?
                title = "Điểm danh lớp \(data?.classroom_name ?? "")"
                subtitle = "Cập nhật: \(data?.lecture_students ?? -1)/\(data?.classroom_students ?? -1) học sinh"
                let leftView = UIImageView(image: #imageLiteral(resourceName: "success"))
                let banner = GrowingNotificationBanner(title: title, subtitle: subtitle, leftView: leftView, style: .success)
                banner.duration = 2.0
                banner.show()
            })
            APIManager.getStudentDetail(id: id!, completion: {(student, error) in
                if let error = error {
                    print(error)
                    return
                }
                let x = StudentInfoModal(
                    name: "ID: \(id!) - \(student!.name)",
                    describe: student!.birthday,
                    avatar: Constant.baseURL+student!.image
                )
                
                let Modal = PopUpModal(presentable: x)
                self.presentPanModal(Modal)
            })
        }
    }
}

