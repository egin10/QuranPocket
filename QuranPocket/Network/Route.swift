//
//  Route.swift
//  QuranPocket
//
//  Created by Agung Dwi Saputra on 11/04/23.
//

import Foundation


enum BaseURL: String {
    case quran = "equran.id/"
    case tafsirQuran,sholat = "api.myquran.com/v1"
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

enum QuranRoute: String {
    case listQuran = ""
}

enum TafsirRoute: String {
    case listTafsir = ""
}
