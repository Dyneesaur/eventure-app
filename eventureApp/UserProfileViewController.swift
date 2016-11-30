//
//  UserProfileViewController.swift
//  eventureApp
//
//  Created by Emad Karim on 11/28/16.
//  Copyright © 2016 eventure-app. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class UserProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func update(_ sender: Any) {
        let storageRef = FIRStorage.storage().reference().child("avatar.png")
        
        if let uploadData = UIImagePNGRepresentation(imageView.image!) {
            storageRef.put(uploadData, metadata: nil)
            storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print(error!)
                } else {
                    let changeRequest = FIRAuth.auth()?.currentUser?.profileChangeRequest()
                    changeRequest?.photoURL = metadata?.downloadURL()
                    changeRequest?.commitChanges() { (error) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            print(FIRAuth.auth()?.currentUser?.photoURL)
                        }
                    }
                }
                
            })
        }
        let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("Users/"+uid!+"/firstName").setValue(firstName.text)
        FIRDatabase.database().reference().child("Users/"+uid!+"/lastName").setValue(lastName.text)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(imageTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        if let photo = FIRAuth.auth()?.currentUser?.photoURL {
            let data = try? Data(contentsOf: photo)
            if let savedData = data {
               imageView.image = UIImage(data: savedData)
            } else {
                imageView.image = UIImage(named: "default_avatar.jpg")
            }
            
        } else {
            imageView.image = UIImage(named: "default_avatar.jpg")
        }
    }
    
    func imageTapped() {
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImage: UIImage?
        if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImage = originalImage
        }
        
        if let newImage = selectedImage{
            imageView.image = newImage
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancel")
        self.dismiss(animated: true, completion: nil)
    }


}
