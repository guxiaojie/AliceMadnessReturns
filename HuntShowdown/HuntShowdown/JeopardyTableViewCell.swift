//
//  JeopardyTableViewCell.swift
//  HuntShowdown
//
//  Created by Guxiaojie on 2018/7/12.
//  Copyright © 2018 SageGu. All rights reserved.
//

import UIKit
import Kingfisher

class JeopardyTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet var btn1: UIButton!
    @IBOutlet var btn2: UIButton!
    @IBOutlet var btn3: UIButton!
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var standfirstLb: UILabel!
    var quiz: Quiz!

    typealias BuzzingClosure = (Int) -> Void
    typealias NextClosure = () -> Void
 
    var nextQuiz: NextClosure?
    var buzzing: BuzzingClosure?
    
    var reading: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        nextView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func buzzingIn(_ sender: Button) {
        if let buzzing = buzzing {
            guard quiz.correctAnswerIndex != nil else {
                //skip
                buzzing(0)
                return
            }
            buzzing( sender.tag == quiz.correctAnswerIndex ? 1 : -1 )
            nextView.isHidden = false
            standfirstLb.text = quiz.standFirst
        }
    }
    
    @IBAction func next(_ sender: Button) {
        nextView.isHidden = true
        if let next = nextQuiz {
            next()
        }
    }
    
    @IBAction func readArticle(_ sender: Button) {
        if let reading = reading {
            reading()
        }
    }
    
    func reloadData(quiz: Quiz) {
        self.quiz = quiz
        
        imgView.kf.setImage(with: URL(string: quiz.imageUrl))
        
        if quiz.headlines.count > 2 {
            btn1.setTitle(quiz.headlines[0], for: UIControlState.normal)
            btn2.setTitle(quiz.headlines[1], for: UIControlState.normal)
            btn3.setTitle(quiz.headlines[2], for: UIControlState.normal)
        }
    }
}
