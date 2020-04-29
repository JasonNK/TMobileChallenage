//
//  DetailViewController.swift
//  TMobileChallenage
//
//  Created by Jason on 4/19/20.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var joinDateLabel: UILabel!
    @IBOutlet weak var numFollowerLabel: UILabel!
    @IBOutlet weak var numFollowingLabel: UILabel!
    @IBOutlet weak var biographyLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var detailTableView: UITableView!
    
    var userDetail: Detail?
    var detailViewModel = DetailViewModel()
    override func viewDidLoad() {
        setUpView()
        searchBar.delegate = self
        detailTableView.dataSource = self
        detailTableView.delegate = self
    }
    
    /*
     Initialize every view components
     */
    func setUpView() {
        navigationItem.title = StringConstants.navigationTitle.rawValue
        guard let username = userDetail?.login else { return }
        avatarImageView.sd_setImage(with: URL(string: userDetail?.avatar_url ?? ""))
        usernameLabel.text = StringConstants.userName.rawValue + username
        emailLabel.text = StringConstants.email.rawValue + (userDetail?.email ?? "")
        locationLabel.text = StringConstants.location.rawValue + (userDetail?.location ?? "")
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: StringConstants.rawDateLocale.rawValue)
        dateFormatter.dateFormat = StringConstants.rawDateFormat.rawValue
        var dateContent = StringConstants.joinDate.rawValue
        if let dateString = userDetail?.created_at, let date = dateFormatter.date(from: dateString) {
            let formatter = DateFormatter()
            formatter.dateFormat = StringConstants.targetDateFormat.rawValue
            dateContent += formatter.string(from: date)
        }
        joinDateLabel.text = dateContent
        numFollowerLabel.text = String(userDetail?.followers ?? 0) +  StringConstants.followers.rawValue
        numFollowingLabel.text = StringConstants.following.rawValue + String(userDetail?.following ?? 0)
        biographyLabel.text = userDetail?.bio
        detailViewModel.getRepo(username: username) {
            DispatchQueue.main.async {
                self.detailViewModel.searchRepos = self.detailViewModel.repos
                self.detailTableView.reloadData()
            }
        }
    }
    
}

extension DetailViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            detailViewModel.searchRepos = detailViewModel.repos
        } else {
            detailViewModel.searchRepos = detailViewModel.repos.filter({ (repo: Repo) -> Bool in
                return repo.name.lowercased().contains(searchText.lowercased())
            })
        }
        self.detailTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        detailViewModel.searchRepos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellTemp = self.detailTableView.dequeueReusableCell(withIdentifier: StringConstants.detailCellIdentifier.rawValue, for: indexPath) as? DetailRepoTableViewCell
        
        guard let cell = cellTemp else {return DetailRepoTableViewCell()}
        cell.setUpCellData(repoName: detailViewModel.searchRepos[indexPath.row].name, fork_count: detailViewModel.searchRepos[indexPath.row].forks_count, start_count: detailViewModel.searchRepos[indexPath.row].stargazers_count)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let urlString = detailViewModel.repos[indexPath.row].html_url else { return }
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
}
