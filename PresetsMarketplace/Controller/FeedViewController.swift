//
//  FeedViewController.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 18/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import UIKit

class FeedViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Feed"
    }

    override func viewDidAppear(_ animated: Bool) {
        let artist = Artist(name: "Dagoberto",
                            about: "Ex-futebolista",
                            profileImageLink: "https://dragoesdareal.com.br/vps/wp-content/uploads/2017/03/Dagoberto-170321.jpg")
        let preset = Preset(name: "Summer Set",
                            artist: artist,
                            description: "Cores quentes, igual você 😏",
                            price: 422.10,
                            imagesLinks: [
                                "https://greekcitytimes.com/wp-content/uploads/2020/04/elena-ktenopoulou-cjzV4WK46qY-unsplash-scaled.jpg"
        ])

        if let vc = UIStoryboard(name: "PresetPreviewViewController", bundle: nil).instantiateViewController(identifier: "PresetPreviewViewController") as? PresetPreviewViewController {
            vc.preset = preset
            vc.modalPresentationStyle = .fullScreen
            navigationController?.present(vc, animated: true, completion: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
