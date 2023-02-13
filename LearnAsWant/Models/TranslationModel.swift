//
//  TranlsationModel.swift
//  LearnAsWant
//
//  Created by Aleksey on 03.02.2023.
//

import Foundation

class TranslationModel: Codable {
    var fromLanguage: GlobalLanguage
    var toLanguage: GlobalLanguage
    var fromText: String?
    var toText: String?

    init(fromLanguage: GlobalLanguage, toLanguage: GlobalLanguage, fromText: String? = nil, toText: String? = nil) {
        self.fromLanguage = fromLanguage
        self.toLanguage = toLanguage
        self.fromText = fromText
        self.toText = toText
    }
}

enum GlobalLanguage: String, CaseIterable, Codable {

    case russian = "Russian"
    case english = "English"
    case german = "German"
    case french = "French"
    case spanish = "Spanish"
    case ukrainian = "Ukrainian"
    case belarusian = "Belarusian"

    var code: String {
        switch self {
        case .russian: return "ru"
        case .english: return "en"
        case .german: return "de"
        case .french: return "fr"
        case .spanish: return "es"
        case .ukrainian: return "uk"
        case .belarusian: return "be"
        }
    }

//    af    Afrikaans
//    ar    Arabic
//    bg    Bulgarian
//    bn    Bengali
//    ca    Catalan
//    cs    Czech
//    cy    Welsh
//    da    Danish
//    el    Greek
//    eo    Esperanto
//    et    Estonian
//    fa    Persian
//    fi    Finnish
//    ga    Irish
//    gl    Galician
//    gu    Gujarati
//    he    Hebrew
//    hi    Hindi
//    hr    Croatian
//    ht    Haitian
//    hu    Hungarian
//    id    Indonesian
//    is    Icelandic
//    it    Italian
//    ja    Japanese
//    ka    Georgian
//    kn    Kannada
//    ko    Korean
//    lt    Lithuanian
//    lv    Latvian
//    mk    Macedonian
//    mr    Marathi
//    ms    Malay
//    mt    Maltese
//    nl    Dutch
//    no    Norwegian
//    pl    Polish
//    pt    Portuguese
//    ro    Romanian
//    sk    Slovak
//    sl    Slovenian
//    sq    Albanian
//    sv    Swedish
//    sw    Swahili
//    ta    Tamil
//    te    Telugu
//    th    Thai
//    tl    Tagalog
//    tr    Turkish
//    ur    Urdu
//    vi    Vietnamese
//    zh    Chinese
//
//
}
