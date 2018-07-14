//
//  DailyBuzz.swift
//  HuntShowdown
//
//  Created by Guxiaojie on 2018/7/12.
//  Copyright © 2018 SageGu. All rights reserved.
//

import UIKit

struct Quiz: Codable {
    var correctAnswerIndex: Int?
    var imageUrl: String
    var standFirst: String
    var storyUrl: String
    var section: String
    var headlines: Array<String>
}

struct DailyBuzz: Codable {
    var product: String
    var resultSize: Int
    var version: Int
    var items: [Quiz]
}

//class DailyBuzz: NSObject {
//
//}
