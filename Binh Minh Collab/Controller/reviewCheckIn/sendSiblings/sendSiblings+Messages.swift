//
//  sendSiblings+Messages.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 9/27/19.
//  Copyright © 2019 Hoàng Sơn Tùng. All rights reserved.
//

import Foundation
import UIKit
import MessageUI
extension sendSiblings {
    
    func getAllPhoneNumberFromOneSection(section: Section) -> String {
        var string = ""
        for student in section.students {
            if student.mother.phone == "" {
                string = string + student.mother.phone + " "
            } else {
                string = string + student.mother.phone + " "
            }
        }
        return string
    }
    
    func generateComposeMessage() {
        let section = sections[count]
        let string = getAllPhoneNumberFromOneSection(section: section)
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: string, range: NSRange(string.startIndex..., in: string))
            
            var numbers = [String]()
            for match in matches{
                if match.resultType == .phoneNumber, let number = match.phoneNumber {
                    numbers.append(number)
                    print(number)
                }
            }
            if (MFMessageComposeViewController.canSendText()) {
                let controller = MFMessageComposeViewController()
                let calendar = Calendar.current
                let time = calendar.dateComponents([.hour,.minute,.second], from: Date())
                controller.body = "TTBM TB: Bây giờ là \(time.hour!):\(time.minute!), cháu chưa đến học lớp: \(section.class_name)"
                controller.recipients = numbers
                controller.messageComposeDelegate = self
                self.present(controller, animated: true, completion: {
                    
                })
            }
        } catch {
            print(error)
        }
    }
    
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: {
            if (self.count<self.sections.count) {
                self.generateComposeMessage()
                self.count+=1
            } else {
                self.count = 0
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
}
