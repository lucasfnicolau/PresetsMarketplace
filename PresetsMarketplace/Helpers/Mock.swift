//
//  Mock.swift
//  PresetsMarketplace
//
//  Created by Lucas Fernandez Nicolau on 22/05/20.
//  Copyright © 2020 Lucas Fernandez Nicolau. All rights reserved.
//

//import Foundation
import UIKit

class Mock {

    static let shared = Mock()
    private(set) lazy var user: User = {
        var name = UIDevice.current.name.replacingOccurrences(of: "iPhone de ", with: "")
        name = name.replacingOccurrences(of: "'s iPhone", with: "")
        let user = User(id: "001027.e58a8a5dbc854b22af1b31fefb26908a.1901", name: name, profileImageLink: "")
        return user
    }()
    private(set) var presets: [Preset] = []

    private init() {
        createPresets()
    }

    func createPresets() {

        // MARK: - Artist mock 0
        let leonardoOliveira = Artist(name: "Leonardo Oliveira", about: "Cinéfilo, esportista e tentando transformar meu hobby em meu trabalho.", profileImageLink: "https://media-exp1.licdn.com/dms/image/C4E03AQHpklS_YuAfiQ/profile-displayphoto-shrink_400_400/0?e=1596067200&v=beta&t=FUWaswy-qlERU-_YPWEwIgSHKSTeRFlnR2p4Oocghe4")

        var dngPath = "Matte"
        let leonardoOliveira0 = Preset(name: dngPath, artist: leonardoOliveira, description: "Transcendência do ruído dos motores para a foto. Uma imagem vale mais que mil palavras; uma imagem de velocidade então, vale mais de 1000 km/h.", dngPath: dngPath, price: 49.99, imagesLinks: [
            "https://i.ibb.co/RhRzQzy/Interlagos-0.jpg",
            "https://i.ibb.co/txBNGXn/Interlagos-1.jpg"
        ])

        dngPath = "Film"
        let leonardoOliveira1 = Preset(name: dngPath, artist: leonardoOliveira, description: "Baseado em filmes antigos.", dngPath: dngPath, price: 500, imagesLinks: [
            "https://i.ibb.co/HXfPbJm/Amazon-0.jpg",
            "https://i.ibb.co/s6k9qjM/Amazon-1.jpg"
        ])

        leonardoOliveira.presets = [leonardoOliveira0, leonardoOliveira1]

        // MARK: - Artist mock 1
        let pedroGuedes = Artist(name: "Pedro Guedes", about: "Economista, fotógrafo e pai da Raquel e da Teresa 👨‍👧‍👧.", profileImageLink: "https://media-exp1.licdn.com/dms/image/C4D03AQG6EataKCjxhw/profile-displayphoto-shrink_400_400/0?e=1596067200&v=beta&t=1yWfPzALKc5Wbja5R3Y2lOYuKEY8AX3Scp1gKQbDLro")

        dngPath = "HDR"
        let pedroGuedes0 = Preset(name: dngPath, artist: pedroGuedes, description: "HDR, para melhorar a iluminação das suas fotos.", dngPath: dngPath, price: 49.99, imagesLinks: [
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
        let lucasNicolau = Artist(name: "Lucas Nicolau", about: "Ex-desenvolvedor que decidiu se aventurar no mundo mágico da fotografia.", profileImageLink: "https://media-exp1.licdn.com/dms/image/C4E03AQE3oPhCGvEvyg/profile-displayphoto-shrink_400_400/0?e=1596067200&v=beta&t=Q8TmrdaNJIalZYD0ZumtsoYr13oAeuHbH5Zds6LpGgU")

        dngPath = "Vintage"
        let lucasNicolau0 = Preset(name: dngPath, artist: lucasNicolau, description: "Deixando as fotos com uma temática dos velhos tempos. Good old days.", dngPath: dngPath, price: 633, imagesLinks: [
            "https://i.ibb.co/Sc9JwrH/California-0.jpg",
            "https://i.ibb.co/zFYM38c/California-1.jpg"
        ])

        dngPath = "Pastel"
        let lucasNicolau1 = Preset(name: dngPath, artist: lucasNicolau, description: "Cores pastéis, deixando a fotografia com tons mais agradáveis.", dngPath: dngPath, price: 500, imagesLinks: [
            "https://i.ibb.co/y8kY1TB/Luxembourg-0.jpg",
            "https://i.ibb.co/MRy9Jp1/Luxembourg-1.jpg"
        ])

        lucasNicolau.presets = [lucasNicolau0, lucasNicolau1]

        // MARK: - Artist mock 3
        let gabrielHenrique = Artist(name: "Gabriel Henrique", about: "Engenheiro civil e fotógrafo nas horas vagas.", profileImageLink: "https://media-exp1.licdn.com/dms/image/C4D03AQEbvJvZCOljHg/profile-displayphoto-shrink_400_400/0?e=1596067200&v=beta&t=H-o3tlWbVCvJMEmnLM_VgK99Ssi6MstZpQ7yWnLgHMQ")

        dngPath = "Monotone"
        let gabrielHenrique0 = Preset(name: dngPath, artist: gabrielHenrique, description: "A arte de explorar um único tom.", dngPath: dngPath, price: 49.99, imagesLinks: [
            "https://i.ibb.co/8jdKpmw/London-0.jpg",
            "https://i.ibb.co/YfwWNLb/London-1.jpg"
        ])

        dngPath = "Duotone"
        let gabrielHenrique1 = Preset(name: dngPath, artist: gabrielHenrique, description: "Um incremento ao Monotone, porém mantendo a sutileza.", dngPath: dngPath, price: 500, imagesLinks: [
            "https://i.ibb.co/FBsjbR4/Skyline-0.jpg",
            "https://i.ibb.co/4fYYqZX/Skyline-1.jpg"
        ])

        gabrielHenrique.presets = [gabrielHenrique0, gabrielHenrique1]

        self.presets = leonardoOliveira.presets + pedroGuedes.presets + lucasNicolau.presets + gabrielHenrique.presets

        user.startFollowing(artist: pedroGuedes)
//        user.startFollowing(artist: leonardoOliveira)
        user.startFollowing(artist: lucasNicolau)
    }
}
