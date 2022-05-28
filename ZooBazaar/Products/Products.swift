//
//  Products.swift
//  
//
//  Created by Maria Khamitsevich on 18.05.22.
//

import UIKit


//MARK: CATS
var royalCanin = BackendProducts(brendName: "Royal Canin", brendProducts: [
    BrandProducts(productName: "Roayl Canin Sterilized",
                  productDescription: "Корм Royal Canin Sterilized 37 для стерилизованных кошек в возрасте от 1 до 7 лет.",
                  productImage: UIImage(named: "roal canin"),
                  productPrice: 17, weights: [.twothousand, .onethousand]),
    BrandProducts(productName: "Royal Canin Maine Coon",
                  productDescription: "Корм Royal Canin Maine Coon разработан специально для кошек породы мейн-кун старше 15 месяцев.",
                  productImage: UIImage(named: "Royal Canin Maine Coon"),
                  productPrice: 30.5, weights: [.twothousand, .threehundred]),
    BrandProducts(productName: "Royal Canin Exigent Savour Sensation",
                  productDescription: "Вкус создан для привередливых кошек. Это два разных вида крокетов, отличающихся по форме, текстуре и составу.",
                  productImage: UIImage(named: "Royal Canin Exigent Savour Sensation"),
                  productPrice: 25.5, weights: [.threehundred, .fivehundred, .twothousand, .onethousand])
])

var whiskas = BackendProducts(brendName: "Whiskas", brendProducts: [
    BrandProducts(productName: "Whiskas for adult cats (Говядина)",
                  productDescription: "Whiskas для стерилизованных кошек (Говядина) — полноценный сухой корм для взрослых кошек и кошек. Whiskas содержит все необходимые витамины и минералы, белки, жиры и углеводы в правильных пропорциях, чтобы поддерживать здоровье вашего питомца от усов до хвоста.",
                  productImage: UIImage(named: "Whiskas for adult cats (Beef)"),
                  productPrice: 7.25, weights: [.twothousand, .onethousand])
]
)

var catsBackendData = BackendData(pet: .cats, backendData: [royalCanin, whiskas])
var catsBackendObtainer = BackendObtainer(data: catsBackendData)
var catsProvider = PetProvider(petObtainer: catsBackendObtainer)


//MARK: DOGS
var chappi = BackendProducts(brendName: "Chappi", brendProducts: [
    BrandProducts(productName: "Chappi корм для собак Мясное изобилие",
                  productDescription: "Полноценный сухой корм для взрослых собак всех пород. Не содержит искусственных ароматизаторов и усилителей вкуса.Мясо для силы и энергии в течение дня.Овощи, травы, злаки для отличного пищеварения. Масла и жиры для блестящей шерсти и здоровой кожи.",
                  productImage: UIImage(named: "Chappi Мясное изобилие"),
                  productPrice: 6, weights: [.twothousand, .onethousand]),
    BrandProducts(productName: "Chappi корм для собак с говядиной",
                  productDescription: "Полноценный сухой корм для взрослых собак всех пород. Не содержит искусственных ароматизаторов и усилителей вкуса.Мясо для силы и энергии в течение дня.Овощи, травы, злаки для отличного пищеварения. Масла и жиры для блестящей шерсти и здоровой кожи.Кальций для крепких зубов и костей.",
                  productImage: UIImage(named: "Chappi корм для собак с говядиной"),
                  productPrice: 6, weights: [.threehundred, .onethousand, .twothousand])
])

var grandorf = BackendProducts(brendName: "Grandorf", brendProducts: [
    BrandProducts(productName: "Grandorf Adult All Breeds (Белая рыба и рис)",
                  productDescription: "Grandorf Sensitive Care Holistic White Fish & Rice All Breeds (Белая рыба, рис) - это гипоаллергенный корм для взрослых собак всех пород старше 1 года. ",
                  productImage: UIImage(named: "Grandorf Adult All Breeds (Белая рыба и рис)"),
                  productPrice: 32, weights: [.twothousand, .onethousand, .threehundred, .fivehundred])
])

var happyDog = BackendProducts(brendName: "Happy Dog", brendProducts: [])

var dogsBackendData = BackendData(pet: .dogs, backendData: [chappi, grandorf])
var dogsBackendObtainer = BackendObtainer(data: dogsBackendData)
var dogsProvider = PetProvider(petObtainer: dogsBackendObtainer)

//MARK: RODENTS
var littleKing = BackendProducts(brendName: "Little King", brendProducts: [
    BrandProducts(productName: "Little King лакомство для грызунов",
                  productDescription: "Подходит для всех видов грызунов, т.к не содержит сладких ингридиентов.Благодаря твердой структуре позволяет удовлетворить естественные потребности зверьков что-то грызть, при этом стачивать острые зубы.",
                  productImage: UIImage(named: "Little King лакомство для грызунов (корзинка зерновая)"),
                  productPrice: 46, weights: [.threehundred, .fivehundred])
])
var littleOne = BackendProducts(brendName: "Little One", brendProducts: [
    BrandProducts(productName: "Little One Корм для морских свинок",
                  productDescription: "Суточная доза корма Little One для морских свинок составляет 35-50 г на зверька в зависимости от его размера.Кормите свинку два раза в день в одно и то же время.Следите, чтобы у морской свинки всегда была свежая вода.",
                  productImage: UIImage(named: "Little One Корм для морских свинок 900гр"),
                  productPrice: 42, weights: [.threehundred, .fivehundred])
])

var rodentsBackendData = BackendData(pet: .rodents, backendData: [littleOne, littleKing])
var rodentsBackendObtainer = BackendObtainer(data: rodentsBackendData)
var rodentsProvider = PetProvider(petObtainer: rodentsBackendObtainer)
