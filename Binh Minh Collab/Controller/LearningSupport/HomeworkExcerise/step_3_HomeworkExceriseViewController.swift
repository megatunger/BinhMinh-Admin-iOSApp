//
//  step_3_HomeworkExceriseViewController.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 3/25/20.
//  Copyright © 2020 Hoàng Sơn Tùng. All rights reserved.
//

import UIKit
import WebKit
import BSImagePicker
import Photos
class step_3_HomeworkExceriseViewController: UIViewController {
    @IBOutlet weak var addGuidelineButton: UIButton!
    @IBOutlet weak var DoneButton: UIButton!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var Activity: UIActivityIndicatorView!
    var questionResponse = QuestionResponse()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            self.isModalInPresentation = true
        }
        ButtonStyle()
        let url = URL(string: Constant.baseURL+(questionResponse.question?.questionURL ?? ""))!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.Activity.hidesWhenStopped = true
            self.Activity.stopAnimating()
        }
    }
    
    private func ButtonStyle() {
        DoneButton.layer.cornerRadius = CGFloat(Constant.cornerRadius)
        DoneButton.layer.borderWidth = 0
        addGuidelineButton.layer.cornerRadius = CGFloat(Constant.cornerRadius)
        addGuidelineButton.layer.borderWidth = 0
    }
    
    @IBAction func closeTap(_ sender: Any) {
        self.navigationController?.dismiss(animated: true)
    }
    
    @IBAction func tapAddGuideline(_ sender: Any) {
        Constant.hud.show(in: self.view)
        let imagePicker = ImagePickerController()
        presentImagePicker(imagePicker, select: { (asset) in
            // User selected an asset. Do something with it. Perhaps begin processing/upload?
        }, deselect: { (asset) in
            // User deselected an asset. Cancel whatever you did when asset was selected.
        }, cancel: { (assets) in
            // User canceled selection.
        }, finish: { (assets) in
            Constant.hud.show(in: self.view)
            let requestOptions = PHImageRequestOptions()
            requestOptions.resizeMode = PHImageRequestOptionsResizeMode.exact
            requestOptions.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
            // this one is key
            requestOptions.isSynchronous = true

            var uploadData = Dictionary<String, String>()
            var count = 0
            for asset in assets
            {
                if (asset.mediaType == PHAssetMediaType.image)
                {
                    PHImageManager.default().requestImage(for: asset , targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.default, options: requestOptions, resultHandler: { (pickedImage, info) in
                        count+=1
                        let imageData = self.convertImageToBase64String(img: pickedImage ?? UIImage())
                        uploadData.updateValue(imageData, forKey: "Image_\(count)")
                        
                    })

                }
            }
            
            imagePicker.dismiss(animated: true, completion: nil)
            Constant.APIManager.uploadQuestionGuidelines(question_hash_id: self.questionResponse.question?.question_hash ?? "", upload_data: uploadData, completion: {(data, error) in
                Constant.hud.dismiss(animated: false)
                let alert = UIAlertController(title: "",
                                              message: "",
                                              preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(_) in
                    self.webView.reload()
                }))
                switch data?.status {
                case "success":
                    alert.title = "Tải lên thành công"
                    alert.message = data?.errorExplain
                    break
                case "failed":
                    alert.title = "Tải lên thất bại"
                    alert.message = data?.errorExplain
                    break
                case .none:
                    break
                case .some(_):
                    break
                }
                self.present(alert, animated: true, completion: nil)
            })
        }, completion: {() in
            Constant.hud.dismiss(animated: true)
        })
    }
    
    func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
}
