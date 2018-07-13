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

    override func viewDidLoad() {
        super.viewDidLoad()

        let skipBtn = UIBarButtonItem(title: "SKIP", style: .plain, target: self, action: #selector(skip(_:)))
        
        navigationItem.rightBarButtonItem = skipBtn
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        self.tableView.register(UINib(nibName: "JeopardyTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "JeopardyCell")
        self.tableView.isScrollEnabled = false
        self.tableView.allowsSelection = false
        
    }
    
    func updateUI() {
        UIView.animate(withDuration: 0.2, animations: {
            self.indexLable.font = UIFont.systemFont(ofSize: 28)
            self.pointLable.font = UIFont.systemFont(ofSize: 28)
        }) { (stop) in
            self.indexLable.font = UIFont.systemFont(ofSize: 23)
            self.pointLable.font = UIFont.systemFont(ofSize: 23)
           self.indexLable.text = String(self.index + 1)
            self.pointLable.text = String(self.points)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        //tableView.clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        
        let dailyBuzz = ExtractionPoint().getDailyBuzz()
        objects = (dailyBuzz?.items)!
        
        super.viewWillAppear(animated)
        
        self.title = dailyBuzz?.product
        updateUI()
        amountLable.text = "/ " + String(objects.count)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc
    func insertNewObject(_ sender: Any) {
    }
    
    @objc
    func skip(_ sender: Any) {
        gotoNextQuiz()
        updateUI()
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
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
        self.tableView.scrollToRow(at: IndexPath(row: self.index, section: 0), at: UITableViewScrollPosition.bottom, animated: true)
    }
    
    // Mark: - Actions
    

    // MARK: - Table View

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: JeopardyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "JeopardyCell", for: indexPath) as! JeopardyTableViewCell
        cell.reloadData(quiz: objects[indexPath.row])
        
        cell.buzzing = { [weak self] (aPoint: Int) -> Void in
            self?.points += aPoint
            self?.updateUI()
        }
        
        cell.nextQuiz = { [weak self]  () -> Void in
            self?.gotoNextQuiz()
        }
        
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

