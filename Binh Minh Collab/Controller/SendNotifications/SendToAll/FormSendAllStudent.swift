//
//  ContentSendAllStudent.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 2/7/20.
//  Copyright © 2020 Hoàng Sơn Tùng. All rights reserved.
//

import Foundation

import Foundation
import UIKit
import Eureka

class FormSendAllStudent: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var titleLabel = ""
        var descriptionLabel = ""
        form +++
            Section(header: "Tiêu đề", footer: "Tiêu đề nên ngắn gọn. Ví dụ: \"Thông báo nghỉ học\"\nChỉ áp dụng cho thông báo đến app.")
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
            
            +++ Section("Phương thức gửi")
            
            <<< SwitchRow() {
                $0.tag = "AppNotify"
                $0.title = "Thông báo qua App"
                $0.value = true
                $0.disabled = true
            }
            .onChange { [weak form] in
                if $0.value == true {
                    form?.inlineRowHideOptions = form?.inlineRowHideOptions?.union(.AnotherInlineRowIsShown)
                }
                else {
                    form?.inlineRowHideOptions = form?.inlineRowHideOptions?.subtracting(.AnotherInlineRowIsShown)
                }
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
                    if (formValues["AppNotify"] as! Bool?) != nil {
                        self.callAppNotifyAPI(title: titleLabel, description: descriptionLabel)
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
        Constant.APIManager.sendNotificationsToAll(title: title ,
                                              description: description,
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
    
}
