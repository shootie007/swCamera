//
//  EffectViewController.swift
//  MyCamera
//
//  Created by 多田秀人 on 2020/09/15.
//  Copyright © 2020 多田秀人. All rights reserved.
//

import UIKit

class EffectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        effectImage.image = originalImage
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // bare image
    var originalImage : UIImage?

    @IBOutlet weak var effectImage: UIImageView!
    let filterArray = [
        "CIPhotoEffectMono",
        "CIPhotEffectChrome",
        "CIPhotEffectFade",
        "CIPhotEffectInstant",
        "CIPhotEffectNoir",
        "CIPhotEffectProcess",
        "CIPhotEffectTonal",
        "CIPhotEffectTransfer",
        "CISepiaTone",
    ]
    var filterSelectNumber = 0
    @IBAction func effectButtonAction(_ sender: Any) {
        // unwrap image and pick up as effectable image
        if let image = originalImage {
            let filterName = filterArray[filterSelectNumber]
            filterSelectNumber += 1
            if filterSelectNumber == filterArray.count {
                filterSelectNumber = 0
            }
            let rotate = image.imageOrientation
            let inputImage = CIImage(image: image)
            guard let effectFilter = CIFilter(name: filterName) else {
                return
            }
            effectFilter.setDefaults()
            effectFilter.setValue(inputImage, forKey: kCIInputImageKey)
            guard let outputImage = effectFilter.outputImage else {
                return
            }
            let ciContext = CIContext(options: nil)
            guard let cgImage = ciContext.createCGImage(outputImage, from: outputImage.extent) else {
                return
            }
            effectImage.image = UIImage(cgImage: cgImage, scale: 1.0, orientation: rotate)
        }
    }
    @IBAction func shareButtonAction(_ sender: Any) {
        if let shareImage = effectImage.image {
            let shareItems = [shareImage]
            let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
            controller.popoverPresentationController?.sourceView = view
            present(controller, animated: true, completion: nil)
        }
    }
    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
