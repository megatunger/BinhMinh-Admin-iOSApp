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
import AVKit
import NotificationBannerSwift
import JGProgressHUD
class rootScanView: ScanView, ScanViewDelegate {

    let APIManager = BinhMinhAPIManager()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hud.textLabel.text = "Đang xử lí"
        delegate = self
    }
    
    func ScanResult(ScanValue: String) {
        let decoder = JSONDecoder()
        self.hud.show(in: self.view)
        do {
            let CheckInRequest = try decoder.decode(AutoCheckInRequest.self, from: Data(ScanValue.utf8))
            APIManager.autoCheckIn(login_token: CheckInRequest.loginToken, otp: CheckInRequest.otp, completion: {(data, error) in
                if let error = error {
                    print(error)
                    return
                }
                self.hud.dismiss()
                switch data?.status {
                    case "failed":
                        AudioServicesPlaySystemSound(1395)
                        let title = "Có lỗi"
                        let subtitle = data?.errorExplain
                        let banner = FloatingNotificationBanner(title: title, subtitle: subtitle, style: .danger)
                        banner.duration = 3.0
                        banner.show()
                    
                    case "warning":
                        AudioServicesPlaySystemSound(1395)
                        let title = "Cảnh báo"
                        let subtitle = data?.errorExplain
                        let banner = FloatingNotificationBanner(title: title, subtitle: subtitle, style: .warning)
                        banner.duration = 3.0
                        banner.show()

                    case "success":
                        AudioServicesPlaySystemSound(1394)
                        let title = "Thành công"
                        let subtitle = "Lớp: \(data?.checkInDetails?.classroomName ?? "")\nCập nhật: \(data?.checkInDetails?.currentStudents ?? -1)/\(data?.checkInDetails?.numberStudents ?? -1) học sinh"
                        let banner = FloatingNotificationBanner(title: title, subtitle: subtitle, style: .success)
                        banner.duration = 3.0
                        banner.show()
                    case .none:
                        break
                    case .some(_):
                        break
                    }
            })
            APIManager.getStudentDetail(encrypted_id: CheckInRequest.loginToken, completion: {(student, error) in
                            if let error = error {
                                print(error)
                                return
                            }
                            let x = StudentInfoModal(
                                name: "ID: \(student?.id ?? -1) - \(student?.studentName ?? "")",
                                describe: student?.birthday ?? "",
                                avatar: Constant.baseURL+(student?.avatar.url ?? "")
                            )
            
                            let Modal = PopUpModal(presentable: x)
                            self.presentPanModal(Modal)
                        })
            print(CheckInRequest)
        } catch {
            let banner = FloatingNotificationBanner(title: "Mã Điểm Danh Không Đúng Định Dạng", subtitle: ScanValue, style: .danger)
            banner.show()
            self.hud.dismiss()
        }


    }
}

