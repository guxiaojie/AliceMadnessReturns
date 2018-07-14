//
//  ExtractionPoint.swift
//  HuntShowdown
//
//  Created by Guxiaojie on 2018/7/12.
//  Copyright © 2018 SageGu. All rights reserved.
//

import UIKit

class ExtractionPoint: NSObject {
    
    func getDailyBuzz() -> DailyBuzz? {
        return getDailyBuzz("game")
    }
    
    func getDailyBuzz(_ fileName: String) -> DailyBuzz? {
        let path = Bundle.main.path(forResource: fileName, ofType: "json")
        if path == nil {
            return nil
        }
        let content = try? String(contentsOfFile: path!)
        let data =  content?.data(using: .utf8)
        let dailyBuzz = try? JSONDecoder().decode(DailyBuzz.self, from: data!)
        return dailyBuzz
    }
    
}
