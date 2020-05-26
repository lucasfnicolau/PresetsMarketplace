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
    private(set) lazy var user: User = {
        let user = User(name: "Usuário", profileImageLink: "https://cdn.pixabay.com/photo/2017/11/15/20/49/head-2952533_1280.png")
        return user
    }()
    private(set) var presets: [Preset] = []

    private init() {
        createPresets()
    }

    func createPresets() {

        // MARK: - Artist mock 0
        let leonardoGuedes = Artist(name: "Leonardo Guedes", about: "O artista mais blogueirinha que você irá conhecer", profileImageLink: "https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=80")

        var dngPath = "Vintage"
        let leonardoGuedesPreset0 = Preset(name: "SPFC", artist: leonardoGuedes, description: "Filtro com as cores do soberano. #SaoPauloDoDiniz", dngPath: dngPath, price: 633, imagesLinks: [
            "https://i0.wp.com/spfcnoticias.com/wp-content/uploads/2016/04/sao-paulo-x-cruzeiro-7.jpg",
            "https://images.daznservices.com/di/library/GOAL/6f/f7/abertura-copa-america-morumbi-14062019_aj8t5ysrqmwh13v9tkx1cxiq6.jpg"
        ])

        dngPath = "Film"
        let leonardoGuedesPreset1 = Preset(name: "Brasil", artist: leonardoGuedes, description: "Todo mundo tenta, mas só o Brasil é penta", dngPath: dngPath, price: 500, imagesLinks: [
            "https://www.osmais.com/wallpapers/201406/selecao-brasileira-wallpaper.jpg",
            "https://adrenaline.com.br/forum/attachments/teamkit_bra_4-jpg.71177/"
        ])

        leonardoGuedes.presets = [leonardoGuedesPreset0, leonardoGuedesPreset1]

        // MARK: - Artist mock 1
        let pedroOliveira = Artist(name: "Pedro Oliveira", about: "O artista mais blogueirinha que você irá conhecer", profileImageLink: "https://images.unsplash.com/photo-1543610892-0b1f7e6d8ac1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80")

        dngPath = "HDR"
        let pedroOliveira0 = Preset(name: "F1 2020", artist: pedroOliveira, description: "F1 vruuuum vruuuum. Velocidade, eu sou a velocidade. KATCHAU!", dngPath: dngPath, price: 49.99, imagesLinks: [
            "https://cdn.wallpapersafari.com/12/85/2WfMJO.jpg",
            "https://wallpaperaccess.com/full/1221877.jpg"
        ])

        dngPath = "Contrast"
        let pedroOliveira1 = Preset(name: "NFL", artist: pedroOliveira, description: "O marido da Gisele é TOP. Enquanto não tem outro Super Bowl, aproveite esse lindo preset.", dngPath: dngPath, price: 500, imagesLinks: [
            "https://wallpaperaccess.com/full/301291.jpg",
            "https://wallpaperaccess.com/full/308967.jpg"
        ])

        pedroOliveira.presets = [pedroOliveira0, pedroOliveira1]

        self.presets = leonardoGuedes.presets + pedroOliveira.presets
    }
}
