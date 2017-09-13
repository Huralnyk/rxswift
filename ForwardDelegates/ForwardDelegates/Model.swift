//
//  Model.swift
//  UseForwardDelegates
//
//  Created by Scott Gardner on 6/5/16.
//  Copyright © 2016 Scott Gardner. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

class Model {
    
    let data = Observable.just([
        SectionModel(model: "A", items: [
            Contributor(name: "Ash Furrow", gitHubID: "ashfurrow")
            ]),
        SectionModel(model: "B", items: [
            Contributor(name: "Junior B.", gitHubID: "bontoJR")
            ]),
        SectionModel(model: "C", items: [
            Contributor(name: "Carlos García", gitHubID: "carlosypunto"),
            Contributor(name: "Cezary Kopacz", gitHubID: "CezaryKopacz")
            ]),
        SectionModel(model: "D", items: [
            Contributor(name: "David Paschich", gitHubID: "dpassage")
            ]),
        SectionModel(model: "E", items: [
            Contributor(name: "Evgeny Aleksandrov", gitHubID: "ealeksandrov"),
            Contributor(name: "Esteban Torres", gitHubID: "esttorhe")
            ]),
        SectionModel(model: "F", items: [
            Contributor(name: "Florent Pillet", gitHubID: "fpillet")
            ]),
        SectionModel(model: "G", items: [
            Contributor(name: "Guy Kahlon", gitHubID: "GuyKahlon")
            ]),
        SectionModel(model: "I", items: [
            Contributor(name: "Marin Todorov", gitHubID: "icanzilb"),
            Contributor(name: "Ivan Bruel", gitHubID: "ivanbruel")
            ]),
        SectionModel(model: "K", items: [
            Contributor(name: "Krunoslav Zaher", gitHubID: "kzaher")
            ]),
        SectionModel(model: "L", items: [
            Contributor(name: "Laurin Brandner", gitHubID: "lbrndnr"),
            Contributor(name: "Leo Picado", gitHubID: "leopic"),
            Contributor(name: "Libor Huspenina", gitHubID: "libec"),
            Contributor(name: "Lukas Lipka", gitHubID: "lipka")
            ]),
        SectionModel(model: "M", items: [
            Contributor(name: "Maximilian Alexander", gitHubID: "mbalex99"),
            Contributor(name: "だいちろ", gitHubID: "mokumoku")
            ]),
        SectionModel(model: "N", items: [
            Contributor(name: "Nathan Kot", gitHubID: "nathankot")
            ]),
        SectionModel(model: "O", items: [
            Contributor(name: "Orta", gitHubID: "orta")
            ]),
        SectionModel(model: "P", items: [
            Contributor(name: "Pedro Piñera Buendía", gitHubID: "pepibumur"),
            Contributor(name: "Chris Jimenez", gitHubID: "PiXeL16")
            ]),
        SectionModel(model: "R", items: [
            Contributor(name: "Rui Costa", gitHubID: "ruipfcosta")
            ]),
        SectionModel(model: "S", items: [
            Contributor(name: "Scott Gardner", gitHubID: "scotteg"),
            Contributor(name: "Sendy Halim", gitHubID: "sendyhalim"),
            Contributor(name: "Serg Dort", gitHubID: "sergdort"),
            Contributor(name: "Spiros Gerokostas", gitHubID: "sger"),
            Contributor(name: "Luke", gitHubID: "sunshinejr")
            ]),
        SectionModel(model: "T", items: [
            Contributor(name: "Thane Gill", gitHubID: "thanegill")
            ]),
        SectionModel(model: "X", items: [
            Contributor(name: "xixi197 Nova", gitHubID: "xixi197")
            ]),
        SectionModel(model: "Y", items: [
            Contributor(name: "Yury Korolev", gitHubID: "yury")
            ]),
        ])
    
}
