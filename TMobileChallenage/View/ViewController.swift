//
//  ViewController.swift
//  TMobileChallenage
//
//  Created by Jason on 4/17/20.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableV: UITableView!
    let viewModel = UserViewModel()
    var isSeaching = false
    var curPage = 1
    let countPerPage = IntConstants.countMainPerPage.rawValue
    var searchText = ""
    var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.delegate = self
        tableV.dataSource = self
        tableV.delegate = self
        tableV.prefetchDataSource = self
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] (t) in
            guard let self = self else {return}
            if !searchText.isEmpty {
                let n = searchText.count
                if n < self.searchText.count { self.curPage = 1 }
                self.isSeaching = true
                let aView = UIActivityIndicatorView()
                aView.center = self.view.center
                aView.startAnimating()
                self.view.addSubview(aView)
                self.searchText = searchText
                self.viewModel.searchFor(username: searchText, curPage: self.curPage) {
                    DispatchQueue.main.async {
                        aView.removeFromSuperview()
                        self.isSeaching = false
                        self.tableV.reloadData()
                    }
                }
            } else {
                self.curPage = 1
                self.searchText = ""
            }
        })
        
        
    }

    

}

extension ViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if indexPath.row == curPage * countPerPage - 1 {
                curPage += 1
                isSeaching = true
                self.searchBar.isUserInteractionEnabled = false
                let aView = UIActivityIndicatorView()
                aView.center = self.view.center
                aView.startAnimating()
                self.view.addSubview(aView)
                viewModel.searchFor(username: searchText, curPage: curPage) {
                    DispatchQueue.main.async {
                        aView.removeFromSuperview()
                        self.searchBar.isUserInteractionEnabled = true
                        self.isSeaching = false
                        let startRow = (self.curPage - 1) * self.countPerPage
                        var indexPaths = [IndexPath]()
                        let endRow = min(startRow + self.countPerPage, self.viewModel.users.count)
                        for row in startRow..<endRow {
                            indexPaths.append(IndexPath(row: row, section: 0))
                        }
                        self.tableV.performBatchUpdates({
                            self.tableV.insertRows(at: indexPaths, with: .none)
                            
                        }, completion: nil)
                        self.tableV.reloadRows(at: indexPaths, with: .none)
                    }
                }
            }
        }
    }

}



extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableV.dequeueReusableCell(withIdentifier: StringConstants.mainCellIdentifier.rawValue, for: indexPath)
        cell.textLabel?.text = viewModel.users[indexPath.row].login
        cell.imageView?.image = UIImage.init(data: viewModel.users[indexPath.row].image ?? Data())
        cell.detailTextLabel?.text = "Repo: \(viewModel.users[indexPath.row].detail?.public_repos ?? 0)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = self.storyboard?.instantiateViewController(identifier: StringConstants.detailViewControllerId.rawValue) as? DetailViewController
        detailViewController?.userDetail = viewModel.users[indexPath.row].detail
        navigationController?.pushViewController(detailViewController!, animated: true)
        
        
    }
    
    
}

