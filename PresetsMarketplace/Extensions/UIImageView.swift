//
//  UIImageView.swift
//  PresetsMarketplace
//
//  Created by Paul Hudson and modified by Lucas Fernandez Nicolau.
// https://www.hackingwithswift.com/example-code/uikit/how-to-load-a-remote-image-url-into-uiimageview
//

import UIKit

extension UIImageView {
    func load(url: String) {
        guard let url = URL(string: url) else { return }
        self.load(url: url)
    }

    func load(url: URL?) {
        guard let url = url else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }

    func load(url: URL?, completion: @escaping (Bool) -> Void) {
        guard let url = url else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        completion(true)
                    }
                }
            }
        }
    }
}
