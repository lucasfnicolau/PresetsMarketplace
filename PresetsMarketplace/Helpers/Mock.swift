//
//  Mock.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 22/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

import Foundation

class Mock {

    static let shared = Mock()
    private(set) var presets: [Preset] = []

    private init() {
        createPresets()
    }

    func createPresets() {

        // MARK: - Artist mock 0
        let leonardoGuedes = Artist(name: "Leonardo Guedes", about: "O artista mais blogueirinha que você irá conhecer", profileImageLink: "https://media-exp1.licdn.com/dms/image/C4E03AQHpklS_YuAfiQ/profile-displayphoto-shrink_400_400/0?e=1595462400&v=beta&t=-9bmhicFb54LcNZVtT9LpoyDvHt-Q_Ms4-Qr-lEBfkM")

        let leonardoGuedesPreset0 = Preset(name: "SPFC", artist: leonardoGuedes, description: "Filtro com as cores do soberano. #SaoPauloDoDiniz", price: 633, imagesLinks: [
            "https://i0.wp.com/spfcnoticias.com/wp-content/uploads/2016/04/sao-paulo-x-cruzeiro-7.jpg",
            "https://images.daznservices.com/di/library/GOAL/6f/f7/abertura-copa-america-morumbi-14062019_aj8t5ysrqmwh13v9tkx1cxiq6.jpg"
        ])

        let leonardoGuedesPreset1 = Preset(name: "Brasil", artist: leonardoGuedes, description: "Todo mundo tenta, mas só o Brasil é penta", price: 500, imagesLinks: [
            "https://www.osmais.com/wallpapers/201406/selecao-brasileira-wallpaper.jpg",
            "https://adrenaline.com.br/forum/attachments/teamkit_bra_4-jpg.71177/"
        ])

        leonardoGuedes.presets = [leonardoGuedesPreset0, leonardoGuedesPreset1]

        // MARK: - Artist mock 1
        let pedroOliveira = Artist(name: "Leonardo Guedes", about: "O artista mais blogueirinha que você irá conhecer", profileImageLink: "https://media-exp1.licdn.com/dms/image/C4E03AQHpklS_YuAfiQ/profile-displayphoto-shrink_400_400/0?e=1595462400&v=beta&t=-9bmhicFb54LcNZVtT9LpoyDvHt-Q_Ms4-Qr-lEBfkM")

        let pedroOliveira0 = Preset(name: "F1 2020", artist: leonardoGuedes, description: "F1 vruuuum vruuuum. Velocidade, eu sou a velocidade. KATCHAU!", price: 49.99, imagesLinks: [
            "https://cdn.wallpapersafari.com/12/85/2WfMJO.jpg",
            "https://wallpaperaccess.com/full/1221877.jpg"
        ])

        let pedroOliveira1 = Preset(name: "NFL", artist: leonardoGuedes, description: "O marido da Gisele é TOP. Enquanto não tem outro Super Bowl, aproveite esse lindo preset.", price: 500, imagesLinks: [
            "https://wallpaperaccess.com/full/301291.jpg",
            "https://wallpaperaccess.com/full/308967.jpg"
        ])

        pedroOliveira.presets = [pedroOliveira0, pedroOliveira1]

        self.presets = leonardoGuedes.presets + pedroOliveira.presets
    }
}
