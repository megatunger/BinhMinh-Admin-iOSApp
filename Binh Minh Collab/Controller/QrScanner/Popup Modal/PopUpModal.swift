//
//  StudentInfo.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 9/15/19.
//  Copyright © 2019 Hoàng Sơn Tùng. All rights reserved.
//

import Foundation
import PanModal
import UIKit
import Kingfisher
class PopUpModal: StackedProfileViewController {
    
    private weak var timer: Timer?
    private var countdown: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateMessage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startTimer()
    }
    
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.countdown -= 1
            self?.updateMessage()
        }
    }
    
    @objc func updateMessage() {
        guard countdown > 0 else {
            invalidateTimer()
            dismiss(animated: true, completion: nil)
            return
        }
//        alertView.message.text = "Thông báo sẽ tắt sau \(countdown) giây"
    }
    
    func invalidateTimer() {
        timer?.invalidate()
    }
    
    deinit {
        invalidateTimer()
    }
    
    // MARK: - Pan Modal Presentable
    
    override var anchorModalToLongForm: Bool {
        return true
    }
    
}
