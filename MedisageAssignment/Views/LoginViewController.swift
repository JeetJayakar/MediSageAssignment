//
//  LoginViewController.swift
//  MedisageAssignment
//
//  Created by Jeet Jaykar on 24/09/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailIdTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailIdTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if viewModel.isValidEmail(emailIdTF.text ?? "") && viewModel.isValidPassword(passwordTF.text ?? ""){
            submitButton.isEnabled = true
        }else{
            submitButton.isEnabled = false
        }
    }

    
    @IBAction func submitTouched(_ sender: UIButton) {
        let postsVC = storyboard?.instantiateViewController(withIdentifier: "PostsViewController") as! PostsViewController
        navigationController?.pushViewController(postsVC, animated: true)
    }
    
}

extension LoginViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    {
        let maxLength = 15
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        if textField == passwordTF{
            return newString.length <= maxLength
        }
        return true
    }
    
}
