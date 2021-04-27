//
//  AddMovieVC.swift
//  Moviedo
//
//  Created by Faisal Babkoor on 4/23/21.
//

import UIKit

protocol MovieDelegate: class {
    func movie(name: String, rate: Double, image: UIImage, types: [Type])
}

class AddMovieVC: UIViewController {
    
    weak var delegate: MovieDelegate?
    @IBOutlet var nameLabel: UITextField!
    @IBOutlet var rateLabel: UITextField!
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var typs: [UIButton]!
    
    var stateButtons = [String: UIColor]()
    var selectedTypes: [Type] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(pickImageFrom))
        movieImage.addGestureRecognizer(tap)
    }
    
    @IBAction func saveButton(sender: UIButton) {
        guard let name = nameLabel.text,
              let rate = Double(rateLabel.text ?? "0.0"),
              rate >= 0, rate <= 10,
              let movieImage = movieImage.image else { return }
        delegate?.movie(name: name, rate: rate, image: movieImage, types: selectedTypes)
        dismiss(animated: true, completion: nil)
    }
    
    func stateButton(for button: UIButton) {
        if button.titleColor(for: .normal) == UIColor.white {
            button.setTitleColor(UIColor(red: 0.013, green: 0.184, blue: 0.286, alpha: 1.0), for: .normal)
            button.backgroundColor = UIColor(red: 0.317, green: 0.85, blue: 0.895, alpha: 1.0)
            let title = Type(rawValue: (button.titleLabel?.text)!)
            selectedTypes.append(title!)
        } else {
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor.lightGray
            selectedTypes.removeAll { $0.rawValue == button.titleLabel?.text }
        }
        print(selectedTypes)
    }
    
    @IBAction func chooseTypePressed(sender: UIButton) {
        switch sender.tag {
            case 1:
                stateButton(for: sender)
            case 2:
                stateButton(for: sender)
            case 3:
                stateButton(for: sender)
            case 4:
                stateButton(for: sender)
            case 5:
                stateButton(for: sender)
            case 6:
                stateButton(for: sender)
            case 7:
                stateButton(for: sender)
            case 8:
                stateButton(for: sender)
            default:
                break
        }
    }
    
    @objc func pickImageFrom() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
}

extension AddMovieVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            movieImage.image = image
        } else if let cropImage = info[.editedImage] as? UIImage{
            movieImage.image = cropImage
        }
        dismiss(animated: true, completion: nil)
    }
}

extension AddMovieVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
