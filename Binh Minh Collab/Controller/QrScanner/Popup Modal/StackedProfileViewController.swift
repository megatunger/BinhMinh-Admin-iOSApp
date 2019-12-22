//
//  StackedProfileViewController.swift
//  PanModal
//
//  Created by Tosin Afolabi on 2/26/19.
//  Copyright © 2019 PanModal. All rights reserved.
//

import UIKit
import PanModal
import Kingfisher
class StackedProfileViewController: UIViewController, PanModalPresentable {

    // MARK: - Properties

    let presentable: StudentInfoModal

    override var prefersStatusBarHidden: Bool {
        return true
    }

    // MARK: - Views

    let avatarView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.8196078431, green: 0.8235294118, blue: 0.8274509804, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let roleLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.7019607843, green: 0.7058823529, blue: 0.7137254902, alpha: 1)
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initializers

    init(presentable: StudentInfoModal) {
        self.presentable = presentable
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Profile"
        view.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.1137254902, blue: 0.1294117647, alpha: 1)
      
        
        view.addSubview(avatarView)
        view.addSubview(nameLabel)
        view.addSubview(roleLabel)

        nameLabel.text = presentable.name
        roleLabel.text = presentable.describe
        
        let x = UIImageView()
        x.setImage(with: presentable.avatar)
        let image = x.image
        avatarView.contentMode = .scaleAspectFit
        avatarView.layer.contents = image?.cgImage
        setupConstraints()
    }

    // MARK: - Layoutt

    func setupConstraints() {

        avatarView.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
        avatarView.heightAnchor.constraint(equalToConstant: 232.0).isActive = true
        avatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        avatarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 25.0).isActive = true

        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 16.0).isActive = true

        roleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        roleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8.0).isActive = true
        bottomLayoutGuide.topAnchor.constraint(greaterThanOrEqualTo: roleLabel.bottomAnchor, constant: 32).isActive = true
    }

    // MARK: - Pan Modal Presentable

    var panScrollable: UIScrollView? {
        return nil
    }

    var longFormHeight: PanModalHeight {
        return .intrinsicHeight
    }

    var anchorModalToLongForm: Bool {
        return false
    }

    var shouldRoundTopCorners: Bool {
        return true
    }

}

extension UIImageView {
    func setImage(with urlString: String){
        guard let url = URL.init(string: urlString) else {
            return
        }
//        let processor = RoundCornerImageProcessor(cornerRadius: 200)
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: "default_profile_icon"),
            options: [
//                .processor(processor)
            ])
    }
}
