//
//  ViewController.swift
//  QuickLookExplorer
//
//  Created by Muhammad Asad Chattha on 14/12/2023.
//

import UIKit
import QuickLook

class ViewController: UIViewController {
    
    enum MessageType {
        case text(String)
        case image(String)
        case doc(String)
    }
    
    var messages: [MessageType] = [
        .text("Hello, this is a text message."),
        .image("Photo"),
        .doc("Doc")
    ]
    

    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var docImageView: UIImageView!
    
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
        docImageView.onClick(action: onClickImage)
    }
}

// MARK: - Actions
extension ViewController {
    
    func onClickImage(_ sender: Any) {
        let tag = (sender as! UIImageView).tag
        let message = messages[tag]

        switch message {
        case let .image(imageName):
            guard let fileURL = Bundle.main.url(forResource: imageName, withExtension: "jpg") else { return }
            presentQuickLook(with: fileURL)

        case let .doc(docName):
            guard let fileURL = Bundle.main.url(forResource: docName, withExtension: "pdf") else { return }
            presentQuickLook(with: fileURL)
        default:
            break
        }
    }
}

// MARK: - QLPreviewControllerDataSource

var previewItems: [QLPreviewItem] = []
extension ViewController: QLPreviewControllerDataSource, QLPreviewControllerDelegate {

    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return previewItems.count
    }

    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return previewItems[index]
    }

    func presentQuickLook(with fileURL: URL) {
        let previewController = QLPreviewController()
        previewController.dataSource = self
        previewController.delegate = self

        // Pass the file name as a preview item
        previewItems = [fileURL as QLPreviewItem]
        present(previewController, animated: true, completion: nil)
    }
}
