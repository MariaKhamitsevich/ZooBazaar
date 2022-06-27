////
////  Products.swift
////  
////
////  Created by Maria Khamitsevich on 18.05.22.
////
//
//import UIKit
//
//
////MARK: CATS
//var royalCanin = BackendProducts(brendName: "Royal Canin", brendProducts: [
//    BrandProducts(productName: "Roayl Canin Sterilized",
//                  productDescription: "Корм Royal Canin Sterilized 37 для стерилизованных кошек в возрасте от 1 до 7 лет.",
//                  productImageURL: UIImage(named: "roal canin"),
//                  productPrice: 17, isPopular: false, productID: 111),
//    BrandProducts(productName: "Royal Canin Maine Coon",
//                  productDescription: "Корм Royal Canin Maine Coon разработан специально для кошек породы мейн-кун старше 15 месяцев.",
//                  productImageURL: UIImage(named: "Royal Canin Maine Coon"),
//                  productPrice: 30.5, isPopular: true, productID: 112),
//    BrandProducts(productName: "Royal Canin Exigent Savour Sensation",
//                  productDescription: "Вкус создан для привередливых кошек. Это два разных вида крокетов, отличающихся по форме, текстуре и составу.",
//                  productImageURL: UIImage(named: "Royal Canin Exigent Savour Sensation"),
//                  productPrice: 25.5, isPopular: true, productID: 113)
//])
//
//var whiskas = BackendProducts(brendName: "Whiskas", brendProducts: [
//    BrandProducts(productName: "Whiskas for adult cats (Говядина)",
//                  productDescription: "Whiskas для стерилизованных кошек (Говядина) — полноценный сухой корм для взрослых кошек и кошек. Whiskas содержит все необходимые витамины и минералы, белки, жиры и углеводы в правильных пропорциях, чтобы поддерживать здоровье вашего питомца от усов до хвоста.",
//                  productImageURL: UIImage(named: "Whiskas for adult cats (Beef)"),
//                  productPrice: 7.25, isPopular: false, productID: 121)
//]
//)
//
//var catsBackendData = BackendData(pet: .cats, backendData: [royalCanin, whiskas])
//var catsBackendObtainer = BackendObtainer(data: catsBackendData)
//var catsProvider = PetProvider(petObtainer: catsBackendObtainer)
//
//
////MARK: DOGS
//var chappi = BackendProducts(brendName: "Chappi", brendProducts: [
//    BrandProducts(productName: "Chappi корм для собак Мясное изобилие",
//                  productDescription: "Полноценный сухой корм для взрослых собак всех пород. Не содержит искусственных ароматизаторов и усилителей вкуса.Мясо для силы и энергии в течение дня.Овощи, травы, злаки для отличного пищеварения. Масла и жиры для блестящей шерсти и здоровой кожи.",
//                  productImageURL: UIImage(named: "Chappi Мясное изобилие"),
//                  productPrice: 6, isPopular: true, productID: 211),
//    BrandProducts(productName: "Chappi корм для собак с говядиной",
//                  productDescription: "Полноценный сухой корм для взрослых собак всех пород. Не содержит искусственных ароматизаторов и усилителей вкуса.Мясо для силы и энергии в течение дня.Овощи, травы, злаки для отличного пищеварения. Масла и жиры для блестящей шерсти и здоровой кожи.Кальций для крепких зубов и костей.",
//                  productImageURL: UIImage(named: "Chappi корм для собак с говядиной"),
//                  productPrice: 6, isPopular: true, productID: 212)
//])
//
//var grandorf = BackendProducts(brendName: "Grandorf", brendProducts: [
//    BrandProducts(productName: "Grandorf Adult All Breeds (Белая рыба и рис)",
//                  productDescription: "Grandorf Sensitive Care Holistic White Fish & Rice All Breeds (Белая рыба, рис) - это гипоаллергенный корм для взрослых собак всех пород старше 1 года. ",
//                  productImageURL: UIImage(named: "Grandorf Adult All Breeds (Белая рыба и рис)"),
//                  productPrice: 32, isPopular: true, productID: 221)
//])
//
//var happyDog = BackendProducts(brendName: "Happy Dog", brendProducts: [])
//
//var dogsBackendData = BackendData(pet: .dogs, backendData: [chappi, grandorf])
//var dogsBackendObtainer = BackendObtainer(data: dogsBackendData)
//var dogsProvider = PetProvider(petObtainer: dogsBackendObtainer)
//
////MARK: RODENTS
//var littleKing = BackendProducts(brendName: "Little King", brendProducts: [
//    BrandProducts(productName: "Little King лакомство для грызунов",
//                  productDescription: "Подходит для всех видов грызунов, т.к не содержит сладких ингридиентов.Благодаря твердой структуре позволяет удовлетворить естественные потребности зверьков что-то грызть, при этом стачивать острые зубы.",
//                  productImageURL: UIImage(named: "Little King лакомство для грызунов (корзинка зерновая)"),
//                  productPrice: 46, isPopular: false, productID: 311)
//])
//var littleOne = BackendProducts(brendName: "Little One", brendProducts: [
//    BrandProducts(productName: "Little One Корм для морских свинок",
//                  productDescription: "Суточная доза корма Little One для морских свинок составляет 35-50 г на зверька в зависимости от его размера.Кормите свинку два раза в день в одно и то же время.Следите, чтобы у морской свинки всегда была свежая вода.",
//                  productImageURL: UIImage(named: "Little One Корм для морских свинок 900гр"),
//                  productPrice: 42, isPopular: false, productID: 321)
//])
//
//var rodentsBackendData = BackendData(pet: .rodents, backendData: [littleOne, littleKing])
//var rodentsBackendObtainer = BackendObtainer(data: rodentsBackendData)
//var rodentsProvider = PetProvider(petObtainer: rodentsBackendObtainer)
