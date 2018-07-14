//
//  MasterViewController.swift
//  HuntShowdown
//
//  Created by Guxiaojie on 2018/7/12.
//  Copyright © 2018 SageGu. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var detailViewController: DetailViewController? = nil
    var objects = [Quiz]()
    var points: Int = 0
    var index: Int = 0
    @IBOutlet var tableView: UITableView!
    @IBOutlet var indexLable: UILabel!
    @IBOutlet var amountLable: UILabel!
    @IBOutlet var pointLable: UILabel!
    @IBOutlet var progressView: ProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let skipBtn = UIBarButtonItem(title: "Skip", style: .plain, target: self, action: #selector(skip(_:)))
        navigationItem.rightBarButtonItem = skipBtn
        
        self.tableView.register(UINib(nibName: "JeopardyTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "JeopardyCell")
        self.tableView.isScrollEnabled = false
        self.tableView.allowsSelection = false
        
    }
    
    func updateHeaderUI() {
        self.indexLable.font = UIFont.systemFont(ofSize: 23)
        self.pointLable.font = UIFont.systemFont(ofSize: 23)
        self.indexLable.text = String(self.index + 1)
        self.pointLable.text = String(self.points)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Guess The Headline" //dailyBuzz?.product

        let amount = quiz(index: index)
        updateHeaderUI()
        amountLable.text = "/" + String(amount)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //just for showing circle progress animation
        self.index -= 1
        gotoNextQuiz()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func quiz(index: Int) -> Int{
        let dailyBuzz = ExtractionPoint().getDailyBuzz()
        let amount = dailyBuzz?.items.count ?? 0
        if (dailyBuzz?.items.count)! > index {
            let slice = dailyBuzz?.items[index...]
            objects = Array(slice!)
        } else {
            objects = (dailyBuzz?.items)!
        }
        return amount
    }
    
    @objc
    func skip(_ sender: Any) {
        progressView.stop()
        updateHeaderUI()
        gotoNextQuiz()
    }
    
    func gotoArticle() {
        if objects.count > index {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let controller: DetailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            controller.sourURL = objects[index].storyUrl
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func gotoNextQuiz() {
        self.index += 1
        if self.index >= objects.count {
            return
        }
        /*
        //going to mark the index, for furture reference
        UserDefaults.standard.setValue(self.index, forKey: "index")
        UserDefaults.standard.synchronize()
        */
        self.tableView.scrollToRow(at: IndexPath(row: self.index, section: 0), at: UITableViewScrollPosition.bottom, animated: true)
        
        //update circle progress
        progressView.animate(10.0)
        progressView.animationEnd = { [weak self] in
            let cell: JeopardyTableViewCell? = self?.tableView.cellForRow(at: IndexPath(row: self?.index ?? -1, section: 0)) as? JeopardyTableViewCell
            cell?.showStandFirst()
            self?.progressView.stop()
        }
    }

    // MARK: - Table View

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: JeopardyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "JeopardyCell", for: indexPath) as! JeopardyTableViewCell
        //data in cell
        cell.reloadData(quiz: objects[indexPath.row])
        
        //choose one of the answers
        cell.buzzing = { [weak self] (aPoint: Int) -> Void in
            self?.points += aPoint
            self?.updateHeaderUI()
            self?.progressView.stop()
        }
        
        //click next
        cell.nextQuiz = { [weak self]  () -> Void in
            self?.gotoNextQuiz()
        }
        
        //click read article
        cell.reading = { [weak self] () -> Void in
            self?.gotoArticle()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let aCell = cell as? JeopardyTableViewCell {
            aCell.updateUI(showQuiz: true)
        }
    }
}

