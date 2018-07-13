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
        let path = Bundle.main.path(forResource: "1game", ofType: "json")
        if path == nil {
            return nil
        }
        let content = try? String(contentsOfFile: path!)
        let data =  content?.data(using: .utf8)
        let dailyBuzz = try? JSONDecoder().decode(DailyBuzz.self, from: data!)
        
        /*
        var catagories: [String] = [String]()
        if let quiz = dailyBuzz?.items {
            for aDailyBuzz in quiz {
                if !catagories.contains(aDailyBuzz.section) {
                    catagories.append(aDailyBuzz.section)
                }
            }
        }
        */
        return dailyBuzz
    }
    
}
