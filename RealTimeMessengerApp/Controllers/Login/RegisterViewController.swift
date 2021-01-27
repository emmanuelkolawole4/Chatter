//
//  RegisterViewController.swift
//  RealTimeMessengerApp
//
//  Created by FOLAHANMI KOLAWOLE on 07/01/2021.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageVIew = UIImageView()
        imageVIew.image = UIImage(systemName: "person.circle")
        imageVIew.tintColor = .gray
        imageVIew.contentMode = .scaleAspectFit
        imageVIew.layer.masksToBounds = true
        imageVIew.layer.borderWidth = 2
        imageVIew.layer.borderColor = UIColor.lightGray.cgColor
        return imageVIew
    }()
    
    private let firstNameField: UITextField = {
        let firstNameField = UITextField()
        firstNameField.autocapitalizationType = .none
        firstNameField.autocorrectionType = .no
        firstNameField.returnKeyType = .continue
        firstNameField.layer.cornerRadius = 12
        firstNameField.layer.borderWidth = 1
        firstNameField.layer.borderColor = UIColor.gray.cgColor
        firstNameField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        firstNameField.leftViewMode = .always
        firstNameField.backgroundColor = .white
        firstNameField.textColor = .black
        firstNameField.attributedPlaceholder = NSAttributedString(string: FirstNameStringConstants.firstNameFieldPlaceholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return firstNameField
    }()
    
    private let lastNameField: UITextField = {
        let lastNameField = UITextField()
        lastNameField.autocapitalizationType = .none
        lastNameField.autocorrectionType = .no
        lastNameField.returnKeyType = .continue
        lastNameField.layer.cornerRadius = 12
        lastNameField.layer.borderWidth = 1
        lastNameField.layer.borderColor = UIColor.gray.cgColor
        lastNameField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        lastNameField.leftViewMode = .always
        lastNameField.backgroundColor = .white
        lastNameField.textColor = .black
        lastNameField.attributedPlaceholder = NSAttributedString(string: LastNameStringConstants.lastNameFieldPlaceholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return lastNameField
    }()
    
    private let emailField: UITextField = {
        let emailField = UITextField()
        emailField.autocapitalizationType = .none
        emailField.autocorrectionType = .no
        emailField.returnKeyType = .continue
        emailField.layer.cornerRadius = 12
        emailField.layer.borderWidth = 1
        emailField.layer.borderColor = UIColor.gray.cgColor
        emailField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        emailField.leftViewMode = .always
        emailField.backgroundColor = .white
        emailField.textColor = .black
        emailField.attributedPlaceholder = NSAttributedString(string: EmailFieldStringConstants.emailFieldPlaceholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return emailField
    }()
    
    private let passwordField: UITextField = {
        let passwordField = UITextField()
        passwordField.autocapitalizationType = .none
        passwordField.autocorrectionType = .no
        passwordField.returnKeyType = .done
        passwordField.layer.cornerRadius = 12
        passwordField.layer.borderWidth = 1
        passwordField.layer.borderColor = UIColor.gray.cgColor
        passwordField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        passwordField.leftViewMode = .always
        passwordField.backgroundColor = .white
        passwordField.isSecureTextEntry = true
        passwordField.textColor = .black
        passwordField.attributedPlaceholder = NSAttributedString(string: PasswordFieldStringConstants.passwordFieldPlaceholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return passwordField
    }()

    private let registerButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle(RegisterButtonStringConstants.registerButtonTitle, for: .normal)
        loginButton.backgroundColor = .link
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 12
        loginButton.layer.masksToBounds = true
        loginButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return loginButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: LoginStringConstants.rightBarButtonItemTitle, style: .done, target: self, action: #selector(didTapRegister))
        
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
        firstNameField.delegate = self
        lastNameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        // Add subviews
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(registerButton)
        
        // add a gesture recognizer to image view so user can tap on it to change profile picture
        imageView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePicture))
        imageView.addGestureRecognizer(gesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width / 3
        
        imageView.frame = CGRect(x: (scrollView.width - size) / 2, y: 20, width: size, height: size)
        imageView.layer.cornerRadius = imageView.width / 2.0
        firstNameField.frame = CGRect(x: 30, y: imageView.bottom + 10, width: scrollView.width - 60, height: 52)
        lastNameField.frame = CGRect(x: 30, y: firstNameField.bottom + 10, width: scrollView.width - 60, height: 52)
        emailField.frame = CGRect(x: 30, y: lastNameField.bottom + 10, width: scrollView.width - 60, height: 52)
        passwordField.frame = CGRect(x: 30, y: emailField.bottom + 10, width: scrollView.width - 60, height: 52)
        registerButton.frame = CGRect(x: 30, y: passwordField.bottom + 10, width: scrollView.width - 60, height: 52)
    }
    
    @objc private func didTapChangeProfilePicture() {
        presentPhotoActionSheet()
    }
    
    @objc private func registerButtonTapped() {
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let firstName = firstNameField.text, let lastName = lastNameField.text, let email = emailField.text, let password = passwordField.text, !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            alertUserRegisterError()
            return
        }
        
        // Firebase Create User
        DatabaseManager.shared.userExists(with: email) { [weak self] exists in
            guard let strongSelf = self else { return }
            guard !exists else {
                // user already exists
                strongSelf.alertUserLoginError(message: "Looks like a user account for that email address already exists.")
                return
            }
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    print("Error creating user")
                    return
                }
                
                DatabaseManager.shared.insertUser(with: ChatAppUser(firstName: firstName, lastName: lastName, emailAddress: email))
    //            let user = result.user
    //            print("Created User: \(user)")
                strongSelf.navigationController?.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    func alertUserLoginError(message: String = "\(UserLoginErrorStringConstants.errorMessage)") {
        let alert = UIAlertController(title: UserLoginErrorStringConstants.errorTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: UserLoginErrorStringConstants.actionTitle, style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    func alertUserRegisterError() {
        let alert = UIAlertController(title: UserRegisterErrorStringConstants.errorTitle, message: UserRegisterErrorStringConstants.errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: UserRegisterErrorStringConstants.actionTitle, style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
//    @objc private func didTapRegister() {
//        let vc = RegisterViewController()
//        vc.title = RegisterStringConstants.title
//        navigationController?.pushViewController(vc, animated: true)
//    }

}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameField {
            lastNameField.becomeFirstResponder()
        } else if textField == lastNameField {
            emailField.becomeFirstResponder()
        } else if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            registerButtonTapped()
        }
        return true
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // present photo action sheet to ask user to take a picture or choose from existing photos
    func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(title: "Profile Picture", message: "How would you like to select a picture", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { [weak self] _ in
            self?.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { [weak self] _ in
            self?.presentPhotoPicker()
        }))
        present(actionSheet, animated: true)
    }
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        self.imageView.image = selectedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
