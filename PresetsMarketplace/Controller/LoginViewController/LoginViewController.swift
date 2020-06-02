//
//  LoginViewController.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 01/06/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit
import AuthenticationServices

class LoginViewController: UIViewController {
    @IBOutlet weak var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSignInWithAppleButton()
        addObserverForAppleIDChangeNotification()
        performExistingAccountSetupFlow()
    }

    func setupSignInWithAppleButton() {
        let button = ASAuthorizationAppleIDButton()
        button.addTarget(self, action: #selector(signInWithAppleButtonTouched), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(button)
    }

    @objc func signInWithAppleButtonTouched() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }

    func addObserverForAppleIDChangeNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(appleIDStateChanged), name: ASAuthorizationAppleIDProvider.credentialRevokedNotification, object: nil)
    }

    @objc func appleIDStateChanged() {
        let provider = ASAuthorizationAppleIDProvider()
        provider.getCredentialState(forUserID: KeychainItem.currentUserIdentifier) { (credentialState, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print(credentialState)
                switch credentialState {
                case .authorized:
                    break
                case .revoked:
                    break
                case .notFound:
                    break
                case .transferred:
                    break
                @unknown default:
                    break
                }
            }
        }
    }

    func performExistingAccountSetupFlow() {
        let requests = [
            ASAuthorizationAppleIDProvider().createRequest(),
            ASAuthorizationPasswordProvider().createRequest()
        ]

        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

    private func saveUserInKeychain(_ userIdentifier: String) {
        do {
            try KeychainItem(service: KeychainInfo.service, account: KeychainInfo.account).saveItem(userIdentifier)
        } catch {
            print("Unable to save userIdentifier to keychain.")
        }
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // TODO
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {

        let userID: String
        switch authorization.credential {
        case let credential as ASAuthorizationAppleIDCredential:
            userID = credential.user
            self.saveUserInKeychain(userID)

        case let credential as ASPasswordCredential:
            userID = credential.user

        default:
            userID = ""
            break
        }

        if !userID.isEmpty {
            print(userID)
        }
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window ?? UIWindow()
    }
}
