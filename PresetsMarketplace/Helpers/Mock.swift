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
        let leonardoOliveira0 = Preset(name: dngPath, artist: leonardoOliveira, description: "Vintage e clássico.", dngPath: dngPath, price: 633, imagesLinks: [
            "https://i.ibb.co/Sc9JwrH/California-0.jpg",
            "https://i.ibb.co/zFYM38c/California-1.jpg"
        ])

        dngPath = "Film"
        let leonardoOliveira1 = Preset(name: dngPath, artist: leonardoOliveira, description: "Baseado em filmes antigos.", dngPath: dngPath, price: 500, imagesLinks: [
            "https://i.ibb.co/HXfPbJm/Amazon-0.jpg",
            "https://i.ibb.co/s6k9qjM/Amazon-1.jpg"
        ])

        leonardoOliveira.presets = [leonardoOliveira0, leonardoOliveira1]

        // MARK: - Artist mock 1
        let pedroGuedes = Artist(name: "Pedro Guedes", about: "Economista, fotógrafo e o preferido", profileImageLink: "https://media-exp1.licdn.com/dms/image/C4D03AQG6EataKCjxhw/profile-displayphoto-shrink_400_400/0?e=1596067200&v=beta&t=1yWfPzALKc5Wbja5R3Y2lOYuKEY8AX3Scp1gKQbDLro")

        dngPath = "HDR"
        let pedroGuedes0 = Preset(name: dngPath, artist: pedroGuedes, description: "HDR, para melhorar a iluminação.", dngPath: dngPath, price: 49.99, imagesLinks: [
            "https://i.ibb.co/wY2WrHq/Brasilia-0.jpg",
            "https://i.ibb.co/L1DDw3c/Brasilia-1.jpg"
        ])

        dngPath = "Contrast"
        let pedroGuedes1 = Preset(name: dngPath, artist: pedroGuedes, description: "Todos sabem da importância de contraste.", dngPath: dngPath, price: 500, imagesLinks: [
            "https://i.ibb.co/D4sy2fT/Europe-0.jpg",
            "https://i.ibb.co/LPJrsnP/Europe-1.jpg"
        ])

        pedroGuedes.presets = [pedroGuedes0, pedroGuedes1]

        // MARK: - Artist mock 2
        let lucasNicolau = Artist(name: "Lucas Nicolau", about: "Não sou dev", profileImageLink: "https://media-exp1.licdn.com/dms/image/C4E03AQE3oPhCGvEvyg/profile-displayphoto-shrink_400_400/0?e=1596067200&v=beta&t=Q8TmrdaNJIalZYD0ZumtsoYr13oAeuHbH5Zds6LpGgU")

        dngPath = "Matte"
        let lucasNicolau0 = Preset(name: dngPath, artist: lucasNicolau, description: "Efeito de matte, para melhorar suas imagens.", dngPath: dngPath, price: 49.99, imagesLinks: [
            "https://i.ibb.co/RhRzQzy/Interlagos-0.jpg",
            "https://i.ibb.co/txBNGXn/Interlagos-1.jpg"
        ])

        dngPath = "Pastel"
        let lucasNicolau1 = Preset(name: dngPath, artist: lucasNicolau, description: "Cores pastéis, deixando a fotografia mais agradável.", dngPath: dngPath, price: 500, imagesLinks: [
            "https://i.ibb.co/y8kY1TB/Luxembourg-0.jpg",
            "https://i.ibb.co/MRy9Jp1/Luxembourg-1.jpg"
        ])

        lucasNicolau.presets = [lucasNicolau0, lucasNicolau1]

        // MARK: - Artist mock 3
        let gabrielHenrique = Artist(name: "Gabriel Henrique", about: "O mestre em CollectionView", profileImageLink: "https://media-exp1.licdn.com/dms/image/C4D03AQEbvJvZCOljHg/profile-displayphoto-shrink_400_400/0?e=1596067200&v=beta&t=H-o3tlWbVCvJMEmnLM_VgK99Ssi6MstZpQ7yWnLgHMQ")

        dngPath = "Monotone"
        let gabrielHenrique0 = Preset(name: dngPath, artist: gabrielHenrique, description: "Um tom único para dar um efeito monótono nas fotos.", dngPath: dngPath, price: 49.99, imagesLinks: [
            "https://i.ibb.co/8jdKpmw/London-0.jpg",
            "https://i.ibb.co/YfwWNLb/London-1.jpg"
        ])

        dngPath = "Duotone"
        let gabrielHenrique1 = Preset(name: dngPath, artist: gabrielHenrique, description: "Duplo tom, melhorando as imagens.", dngPath: dngPath, price: 500, imagesLinks: [
            "https://i.ibb.co/FBsjbR4/Skyline-0.jpg",
            "https://i.ibb.co/4fYYqZX/Skyline-1.jpg"
        ])

        gabrielHenrique.presets = [gabrielHenrique0, gabrielHenrique1]

        self.presets = leonardoOliveira.presets + pedroGuedes.presets + lucasNicolau.presets + gabrielHenrique.presets

        user.startFollowing(artirt: pedroGuedes)
        user.startFollowing(artirt: leonardoOliveira)
        user.startFollowing(artirt: lucasNicolau)
    }
}
