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
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var standfirstLb: UILabel!
    @IBOutlet var answersBtn: [UIButton]!
    typealias BuzzingClosure = (Int) -> Void
    typealias NextClosure = () -> Void
    var nextQuiz: NextClosure?
    var buzzing: BuzzingClosure?
    var reading: (() -> Void)?
    var quiz: Quiz!

    override func awakeFromNib() {
        super.awakeFromNib()
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
            UIView.animate(withDuration: 0.5, animations: {
                for btn in self.answersBtn {
                    if btn.tag == self.quiz.correctAnswerIndex {
                        btn.backgroundColor = UIColor.rightAnswerBgColor
                    } else {
                        btn.backgroundColor = UIColor.wrongAnswerBgColor
                    }
                }
            }, completion: { (stop) in
                buzzing( sender.tag == self.quiz.correctAnswerIndex ? 1 : -1 )
                
                self.showStandFirst()
            })

        }
    }
    
    @IBAction func next(_ sender: Button) {
        updateUI(showQuiz: false)
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
            for btn in answersBtn {
                btn.setTitle(quiz.headlines[btn.tag], for: .normal)
                btn.titleLabel?.numberOfLines = 0
            }
        }
    }
    
    func showStandFirst() {
        UIView.animate(withDuration: 0.5, animations: {
            self.updateUI(showQuiz: false)
            self.standfirstLb.text = self.quiz.standFirst
        })
    }
    
    func updateUI(showQuiz: Bool) {
        nextView.alpha = showQuiz ? 0 : 1
        answersBtn.forEach { (btn) in
            btn.isHidden = !showQuiz
            btn.backgroundColor = UIColor.white
        }
    }
}
