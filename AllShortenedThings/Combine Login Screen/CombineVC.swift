//
//  CombineVC.swift
//  AllShortenedThings
//
//  Created by Hasan Dag on 30.12.2021.
//

import UIKit
import Combine

final class CombineVC: UIViewController {
    @IBOutlet private var userNameTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var tncSwitch: UISwitch!
    @IBOutlet private var signupButton: UIButton!
    
    @Published private var isTnCAccepted: Bool = false
    @Published private var username: String = ""
    @Published private var password: String = ""
    
    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    
    private var signupValidationPublisher: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest3($isTnCAccepted, $username, $password)
            .map { isTnCAccepted, username, password in
                isTnCAccepted && !username.isEmpty && !password.isEmpty
            }
            .eraseToAnyPublisher()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signupValidationPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: signupButton)
            .store(in: &subscriptions)
    }
    
    @IBAction private func didToggleTnCSwitch(_ sender: UISwitch) {
        isTnCAccepted = sender.isOn
    }
    
    @IBAction private func didChangeUsername(_ sender: UITextField) {
        username = sender.text ?? ""
    }
    
    @IBAction private func didChangePassword(_ sender: UITextField) {
        password = sender.text ?? ""
    }
    
    @IBAction private func didClickOnSubmitButton(_ sender: UIButton) {
    }
}
