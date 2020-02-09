//
//  ContentSendEvent.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 2/6/20.
//  Copyright © 2020 Hoàng Sơn Tùng. All rights reserved.
//

import Foundation
import UIKit
import Eureka
import MessageUI

class ContentSendEvent: FormViewController, MFMessageComposeViewControllerDelegate {
    var selectedStudentID = [EventStudents]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var titleLabel = ""
        var descriptionLabel = ""
        form +++
            Section(header: "Tiêu đề", footer: "Tiêu đề nên ngắn gọn. Ví dụ: \"Thông báo nghỉ học\"\nChỉ áp dụng cho thông báo đến app. Nếu gửi bằng SMS phần tiêu đề sẽ bị lược bỏ.")
            <<< NameRow() {
                $0.tag = "Title"
                $0.placeholder = "Thông báo nghỉ học"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
            }
            .onChange({ title in
                titleLabel = title.value ?? ""
            })
            
            +++ Section("Nội dung")
            
            <<< TextAreaRow() {
                $0.tag = "Description"
                $0.placeholder = "TT Bình Minh thông báo: Ca Toán 6h-7h30 chiều ngày T4 được nghỉ vì thầy có việc bận."
                $0.textAreaHeight = .dynamic(initialTextViewHeight: 110)
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
            }
            .onChange({ description in
                descriptionLabel = description.value ?? ""
            })
            
            +++ Section(header: "Phương thức gửi", footer: "Lưu ý: Gửi tin nhắn phụ huynh bao gồm cả bố và mẹ.")
            
            <<< SwitchRow() {
                $0.tag = "AppNotify"
                $0.title = "Thông báo qua App"
                $0.value = true
            }
            .onChange { [weak form] in
                if $0.value == true {
                    form?.inlineRowHideOptions = form?.inlineRowHideOptions?.union(.AnotherInlineRowIsShown)
                }
                else {
                    form?.inlineRowHideOptions = form?.inlineRowHideOptions?.subtracting(.AnotherInlineRowIsShown)
                }
            }
            <<< SwitchRow() {
                $0.tag = "SMSNotify"
                $0.title = "Gửi tin nhắn SMS"
                $0.value = false
            }
            
            <<< SwitchRow(){
                $0.tag = "ParentsNotify"
                $0.title = "Gửi tin nhắn đến phụ huynh"
                $0.value = false
                $0.hidden = .function(["SMSNotify"], { form -> Bool in
                    let row: RowOf<Bool>! = form.rowBy(tag: "SMSNotify")
                    return row.value ?? false == false
                })
            }
            
            +++ Section()
            <<< ButtonRow() {
                $0.title = "Gửi"
            }
            .onCellSelection { cell, row in
                
                let dialogMessage = UIAlertController(title: "Xác nhận", message: "Bạn có chắc chắn muốn gửi không?", preferredStyle: .alert)
                
                // Create OK button with action handler
                let ok = UIAlertAction(title: "Đồng ý", style: .default, handler: { (action) -> Void in
                    let formValues = self.form.values()
                    
                    // Case App Notify Enabled
                    if let AppNotify = formValues["AppNotify"] as! Bool? {
                        if AppNotify {
                            self.callAppNotifyAPI(title: titleLabel, description: descriptionLabel)
                        }
                    }
                    
                    // Case SMS Notify Enabled
                    if let SMSNotify = formValues["SMSNotify"] as! Bool? {
                        if SMSNotify {
                            // Case Parents Notify Enabled
                            if let ParentsNotify = formValues["ParentsNotify"] as! Bool? {
                                if ParentsNotify {
                                    self.callSMSNotifyAPI(parentsNotify: true, body: formValues["Description"] as! String)
                                } else {
                                    self.callSMSNotifyAPI(parentsNotify: false, body: formValues["Description"] as! String)
                                }
                            }
                        }
                    }
                })
                
                // Create Cancel button with action handlder
                let cancel = UIAlertAction(title: "Huỷ", style: .cancel)
                
                //Add OK and Cancel button to dialog message
                dialogMessage.addAction(ok)
                dialogMessage.addAction(cancel)
                
                // Present dialog message to user
                self.present(dialogMessage, animated: true, completion: nil)
                
        }
    }
    
    func callAppNotifyAPI(title: String, description: String) {
        Constant.hud.show(in: self.view)
        Constant.APIManager.sendNotifications(title: title ,
                                              description: description ,
                                              student_ids: selectedStudentID.map { $0.id },
                                              completion: {(data, error) in
                                                Constant.hud.dismiss()
                                                switch data?.status {
                                                case "failed":
                                                    let alert = UIAlertController(title: "Có lỗi xảy ra", message: data?.errorExplain, preferredStyle: UIAlertController.Style.alert)
                                                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                                    self.present(alert, animated: true, completion: nil)
                                                case "success":
                                                    let alert = UIAlertController(title: "Thành công", message: data?.errorExplain, preferredStyle: UIAlertController.Style.alert)
                                                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in
                                                        self.navigationController?.popToViewController(ofClass: SendNotificationsVC.self)
                                                    }))
                                                    self.present(alert, animated: true, completion: nil)
                                                case .none:
                                                    break
                                                case .some(_):
                                                    break
                                                }
        })
    }
    
    // TODO: COMPOSE SMS HERE
    func callSMSNotifyAPI(parentsNotify: Bool, body: String) {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = body
            if parentsNotify {
                let student_phones = selectedStudentID.map { $0.phone }
                let father_phones = selectedStudentID.map { $0.fatherPhone }
                let mother_phones = selectedStudentID.map { $0.motherPhone }
                controller.recipients = student_phones + father_phones + mother_phones
            } else {
                controller.recipients = selectedStudentID.map { $0.phone }
            }
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController!, didFinishWith result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismiss(animated: true, completion: nil)
    }
}
