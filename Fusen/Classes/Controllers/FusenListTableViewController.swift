//
//  FusenListTableViewController.swift
//  Fusen
//
//  Created by shogo okamuro on 2017/03/31.
//  Copyright © 2017 ro.okamu. All rights reserved.
//

import UIKit
import SwipeCellKit

class FusenListTableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    fileprivate var buttonDisplayMode: ButtonDisplayMode = .titleAndImage
    var buttonStyle: ButtonStyle = .backgroundColor
    private var nextVC: FusenViewController?
    fileprivate var memoList: [Memo] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewSetUp()
        MemoViewModel.sharedInstance.memoList.observe { _ in
            self.memoList = MemoViewModel.sharedInstance.memoList.value
            self.tableView.reloadData()
        }
    }
    
    @IBAction func addNew(_ sender: Any) {
        self.performSegue(withIdentifier: "fusen", sender: nil)
        let memo = MemoModel.create()
        self.nextVC?.memo = memo
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        self.nextVC = segue.destination as? FusenViewController
    }
    
}

extension FusenListTableViewController: UITableViewDataSource, UITableViewDelegate, SwipeTableViewCellDelegate {
    fileprivate func tableViewSetUp() {
        self.tableView.register(UINib(nibName: "FusenListTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tableView.allowsSelection = true
        self.tableView.allowsMultipleSelectionDuringEditing = true
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        self.view.layoutMargins.left = 32
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "fusen", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FusenListTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        cell.label.text = self.memoList[indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        
        return options
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            MemoModel.remove(at: indexPath.row)
            self.memoList.remove(at: indexPath.row)
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete")
        
        let more = SwipeAction(style: .default, title: nil) { action, indexPath in
            
        }
        configure(action: more, with: .icon)
        
        return [deleteAction, more]
    }
    
    func configure(action: SwipeAction, with descriptor: ActionDescriptor) {
        action.title = descriptor.title(forDisplayMode: buttonDisplayMode)
        action.image = descriptor.image(forStyle: buttonStyle, displayMode: buttonDisplayMode)
        
        switch buttonStyle {
        case .backgroundColor:
            action.backgroundColor = descriptor.color
        case .circular:
            action.backgroundColor = .clear
            action.textColor = descriptor.color
            action.font = .systemFont(ofSize: 13)
            action.transitionDelegate = ScaleTransition.default
        }
    }
    
}
