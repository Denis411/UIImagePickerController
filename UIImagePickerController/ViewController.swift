//
//  ViewController.swift
//  UIImagePickerController
//
//  Created by Dennis Loskutov on 14.03.2022.
//

import UIKit

class ViewController: UIViewController {
    let screenHeight = UIScreen.main.bounds.width
    
    let buttonPhoto: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.setTitle("Take a picture", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(.red, for: .highlighted)
        button.setTitle("OK", for: .highlighted)
        button.addTarget(self, action: #selector(actionPhoto), for: .touchUpInside)
        return button
    }()
    
    let buttonLibrary: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.setTitle("Choose a picture", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(.red, for: .highlighted)
        button.setTitle("OK", for: .highlighted)
        button.addTarget(self, action: #selector(actionLibrary), for: .touchUpInside)
        return button
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        //      if you do not use backgroundColor you see the color of the window (balck)
        iv.backgroundColor = .orange
        iv.image = UIImage(systemName: "umbrella")!
        return iv
    }()
    
//    override func loadView() {
////        view = imageView
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUIFacad()
    }
    
    //    Setting up UI
    private func setUpUIFacad() {
        setUpImageViewConstraints()
        buttonPhotoConstraints()
        buttonLibraryConstraints()
    }
    
    private func buttonPhotoConstraints() {
        view.addSubview(buttonPhoto)
        buttonPhoto.translatesAutoresizingMaskIntoConstraints = false
        buttonPhoto.heightAnchor.constraint(equalToConstant: 75).isActive = true
        buttonPhoto.widthAnchor.constraint(equalToConstant: screenHeight * 0.75).isActive = true
        buttonPhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonPhoto.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
    }
    
    private func buttonLibraryConstraints() {
        view.addSubview(buttonLibrary)
        buttonLibrary.translatesAutoresizingMaskIntoConstraints = false
        buttonLibrary.heightAnchor.constraint(equalToConstant: 75).isActive = true
        buttonLibrary.widthAnchor.constraint(equalToConstant: screenHeight * 0.75).isActive = true
        buttonLibrary.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonLibrary.bottomAnchor.constraint(equalTo: buttonPhoto.topAnchor, constant: -10).isActive = true
    }
    
    private func setUpImageViewConstraints() {
        view.addSubview(imageView)
        imageView.frame = view.frame
    }
    
    //    Button selectors
    
    @objc func actionPhoto() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        self.present(vc, animated: true, completion: nil)
    }

    @objc func actionLibrary() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        self.present(vc, animated: true, completion: nil)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancelled")
        picker.dismiss(animated: true, completion: nil)
    }
}
