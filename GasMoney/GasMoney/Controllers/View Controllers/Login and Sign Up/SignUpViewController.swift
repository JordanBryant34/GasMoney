//
//  SignUpViewController.swift
//  GasMoney
//
//  Created by Owen Gaudio on 11/30/20.
//

import UIKit

class SignUpViewController: UIViewController {
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "signInBackground")
        imageView.alpha = 0.2
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "gasMoneyLogo")?.resize(newSize: CGSize(width: 150, height: 150))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 27.5)
        label.text = "Create Account"
        label.textColor = .gasGreen()
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let usernameTextField: GasMoneyTextField = {
        let textField = GasMoneyTextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)])
        textField.backgroundColor = .subLabelGray()
        textField.layer.borderColor = UIColor.gasGray().cgColor
        textField.autocorrectionType = .no
        textField.returnKeyType = .next
        textField.clearButtonMode = .whileEditing
        textField.tag = 0
        return textField
    }()
    
    let emailTextField: GasMoneyTextField = {
        let textField = GasMoneyTextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)])
        textField.backgroundColor = .subLabelGray()
        textField.autocorrectionType = .no
        textField.keyboardType = .emailAddress
        textField.layer.borderColor = UIColor.gasGray().cgColor
        textField.returnKeyType = .next
        textField.clearButtonMode = .whileEditing
        textField.tag = 1
        return textField
    }()
    
    let passwordTextField: GasMoneyTextField = {
        let textField = GasMoneyTextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)])
        textField.backgroundColor = .subLabelGray()
        textField.layer.borderColor = UIColor.gasGray().cgColor
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.tag = 2
        return textField
    }()
    
    let createAccountButton: RoundedButton = {
        let button = RoundedButton()
        button.setBackgroundImage(UIImage(color: .gasGray()), for: .disabled)
        button.setBackgroundImage(UIImage(color: UIColor.gasGreen()), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.subLabelGray(), for: .disabled)
        button.setTitle("Create Account", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.isEnabled = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegatesAndActions()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        makeNavigationBarClear()
    }
    
    private func setDelegatesAndActions() {
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
        createAccountButton.addTarget(self, action: #selector(createNewAccountButtonTapped), for: .touchUpInside)
    }
    
    private func setupViews() {
        view.backgroundColor = .offWhite()
        
        view.addSubview(backgroundImageView)
        view.addSubview(logoImageView)
        view.addSubview(welcomeLabel)
        view.addSubview(usernameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(createAccountButton)
        
        backgroundImageView.pinEdgesToView(view: view)
        
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.015).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        welcomeLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20).isActive = true
        
        usernameTextField.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -7.5).isActive = true
        usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        usernameTextField.setHeightAndWidthConstants(height: 50, width: view.frame.width * 0.8)
        
        emailTextField.centerInView(view: view)
        emailTextField.setHeightAndWidthConstants(height: 50, width: view.frame.width * 0.8)
        
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 7.5).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.setHeightAndWidthConstants(height: 50, width: view.frame.width * 0.8)
        
        createAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        createAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        createAccountButton.setHeightAndWidthConstants(height: 70, width: view.frame.width * 0.8)
    }
    
    private func checkIfReadyToContinue() {
        createAccountButton.isEnabled = false
        if let email = emailTextField.text, let password = passwordTextField.text, let username = usernameTextField.text {
            if !email.isEmpty && !password.isEmpty && !username.isEmpty {
                createAccountButton.isEnabled = true
            }
        }
    }
    
    @objc private func createNewAccountButtonTapped() {
        guard let username = usernameTextField.text, !username.isEmpty else { return }
        guard let email = emailTextField.text, !email.isEmpty else { return }
        guard let password = passwordTextField.text, !password.isEmpty else { return }
        
        createAccountButton.isEnabled = false
        
        UserController.createNewUser(username: username, email: email, password: password) { [weak self] (result) in
            switch result {
            case .success(_):
                self?.navigationController?.pushViewController(TripsListViewController(), animated: true)
            case .failure(let error):
                print(error.localizedDescription)
                print(error)
            }
            
            self?.checkIfReadyToContinue()
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    deinit {
        print("\n\nSignInViewController Deinit\n\n")
    }
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.gasGreen().cgColor
        checkIfReadyToContinue()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.subLabelGray().cgColor
        checkIfReadyToContinue()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
           nextField.becomeFirstResponder()
        } else {
           textField.resignFirstResponder()
        }
        
        checkIfReadyToContinue()
        
        return false
    }
    
}
