//
//  ViewController.swift
//  QuickLookExplorer
//
//  Created by Muhammad Asad Chattha on 14/12/2023.
//

import UIKit
import QuickLook

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        attachOnClicks()
    }
    
}

// MARK: - Setup
extension ViewController {
    
    func attachOnClicks() {
        imageView.onClick(action: onClickImage)
    }
}

// MARK: - Actions
extension ViewController {
    
    func onClickImage() {
        print("Image Tapped")
        let previewController = QLPreviewController()
        previewController.dataSource = self
        present(previewController, animated: true)
    }
    
}

// MARK: - QLPreviewControllerDataSource
extension ViewController: QLPreviewControllerDataSource {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        guard let image = UIImage(named: "Photo") else { fatalError("Could not load Photo.png from Assets") }
        // Save the image to a temporary file
        let temporaryDirectory = FileManager.default.temporaryDirectory
        let imageUrl = temporaryDirectory.appendingPathComponent("Photo.png")
        
        do {
            try image.pngData()?.write(to: imageUrl)
        } catch {
            fatalError("Error saving image to temporary file: \(error)")
        }
        
        return imageUrl as QLPreviewItem
    }
}

