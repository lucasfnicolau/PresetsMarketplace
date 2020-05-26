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
        let leonardoOliveira = Artist(name: "Leonardo Oliveira", about: "O artista mais boleiro que você irá conhecer", profileImageLink: "https://media-exp1.licdn.com/dms/image/C4E03AQHpklS_YuAfiQ/profile-displayphoto-shrink_400_400/0?e=1596067200&v=beta&t=FUWaswy-qlERU-_YPWEwIgSHKSTeRFlnR2p4Oocghe4")

        var dngPath = "Vintage"
        let leonardoOliveira0 = Preset(name: dngPath, artist: leonardoOliveira, description: "Filtro com as cores do soberano. #SaoPauloDoDiniz", dngPath: dngPath, price: 633, imagesLinks: [
            "https://i0.wp.com/spfcnoticias.com/wp-content/uploads/2016/04/sao-paulo-x-cruzeiro-7.jpg",
            "https://images.daznservices.com/di/library/GOAL/6f/f7/abertura-copa-america-morumbi-14062019_aj8t5ysrqmwh13v9tkx1cxiq6.jpg"
        ])

        dngPath = "Film"
        let leonardoOliveira1 = Preset(name: dngPath, artist: leonardoOliveira, description: "Todo mundo tenta, mas só o Brasil é penta", dngPath: dngPath, price: 500, imagesLinks: [
            "https://www.osmais.com/wallpapers/201406/selecao-brasileira-wallpaper.jpg",
            "https://adrenaline.com.br/forum/attachments/teamkit_bra_4-jpg.71177/"
        ])

        leonardoOliveira.presets = [leonardoOliveira0, leonardoOliveira1]

        // MARK: - Artist mock 1
        let pedroGuedes = Artist(name: "Pedro Guedes", about: "Economista, fotógrafo e o preferido", profileImageLink: "https://media-exp1.licdn.com/dms/image/C4D03AQG6EataKCjxhw/profile-displayphoto-shrink_400_400/0?e=1596067200&v=beta&t=1yWfPzALKc5Wbja5R3Y2lOYuKEY8AX3Scp1gKQbDLro")

        dngPath = "HDR"
        let pedroGuedes0 = Preset(name: dngPath, artist: pedroGuedes, description: "F1 vruuuum vruuuum. Velocidade, eu sou a velocidade. KATCHAU!", dngPath: dngPath, price: 49.99, imagesLinks: [
            "https://cdn.wallpapersafari.com/12/85/2WfMJO.jpg",
            "https://wallpaperaccess.com/full/1221877.jpg"
        ])

        dngPath = "Contrast"
        let pedroGuedes1 = Preset(name: dngPath, artist: pedroGuedes, description: "O marido da Gisele é TOP. Enquanto não tem outro Super Bowl, aproveite esse lindo preset.", dngPath: dngPath, price: 500, imagesLinks: [
            "https://wallpaperaccess.com/full/301291.jpg",
            "https://wallpaperaccess.com/full/308967.jpg"
        ])

        pedroGuedes.presets = [pedroGuedes0, pedroGuedes1]

        // MARK: - Artist mock 2
        let lucasNicolau = Artist(name: "Lucas Nicolau", about: "Não sou dev", profileImageLink: "https://media-exp1.licdn.com/dms/image/C4E03AQE3oPhCGvEvyg/profile-displayphoto-shrink_400_400/0?e=1596067200&v=beta&t=Q8TmrdaNJIalZYD0ZumtsoYr13oAeuHbH5Zds6LpGgU")

        dngPath = "Matte"
        let lucasNicolau0 = Preset(name: dngPath, artist: lucasNicolau, description: "F1 vruuuum vruuuum. Velocidade, eu sou a velocidade. KATCHAU!", dngPath: dngPath, price: 49.99, imagesLinks: [
            "https://cdn.wallpapersafari.com/12/85/2WfMJO.jpg",
            "https://wallpaperaccess.com/full/1221877.jpg"
        ])

        dngPath = "Pastel"
        let lucasNicolau1 = Preset(name: dngPath, artist: lucasNicolau, description: "O marido da Gisele é TOP. Enquanto não tem outro Super Bowl, aproveite esse lindo preset.", dngPath: dngPath, price: 500, imagesLinks: [
            "https://wallpaperaccess.com/full/301291.jpg",
            "https://wallpaperaccess.com/full/308967.jpg"
        ])

        lucasNicolau.presets = [lucasNicolau0, lucasNicolau1]

        // MARK: - Artist mock 3
        let gabrielHenrique = Artist(name: "Gabriel Henrique", about: "O mestre em CollectionView", profileImageLink: "https://media-exp1.licdn.com/dms/image/C4D03AQEbvJvZCOljHg/profile-displayphoto-shrink_400_400/0?e=1596067200&v=beta&t=H-o3tlWbVCvJMEmnLM_VgK99Ssi6MstZpQ7yWnLgHMQ")

        dngPath = "Monotone"
        let gabrielHenrique0 = Preset(name: dngPath, artist: gabrielHenrique, description: "F1 vruuuum vruuuum. Velocidade, eu sou a velocidade. KATCHAU!", dngPath: dngPath, price: 49.99, imagesLinks: [
            "https://cdn.wallpapersafari.com/12/85/2WfMJO.jpg",
            "https://wallpaperaccess.com/full/1221877.jpg"
        ])

        dngPath = "Duotone"
        let gabrielHenrique1 = Preset(name: dngPath, artist: gabrielHenrique, description: "O marido da Gisele é TOP. Enquanto não tem outro Super Bowl, aproveite esse lindo preset.", dngPath: dngPath, price: 500, imagesLinks: [
            "https://wallpaperaccess.com/full/301291.jpg",
            "https://wallpaperaccess.com/full/308967.jpg"
        ])

        gabrielHenrique.presets = [gabrielHenrique0, gabrielHenrique1]

        self.presets = leonardoOliveira.presets + pedroGuedes.presets + lucasNicolau.presets + gabrielHenrique.presets

        user.startFollowing(artirt: pedroGuedes)
        user.startFollowing(artirt: leonardoOliveira)
        user.startFollowing(artirt: lucasNicolau)
    }
}
