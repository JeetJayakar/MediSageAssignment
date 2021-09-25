//
//  PostsViewController.swift
//  MedisageAssignment
//
//  Created by Jeet Jaykar on 24/09/21.
//

import UIKit

class PostsViewController: UIViewController {
    let viewModel = PostsViewModel()
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchAllPosts()
        viewModel.updateData = {[unowned self] success in
            if success{
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
                
            }else{
                
            }
        }
    }
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
}


extension PostsViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentController.selectedSegmentIndex == 0{
            return viewModel.getAllPostsCount()
        }else{
            return viewModel.getFavouritePostCount()
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        if segmentController.selectedSegmentIndex == 0{
            cell.textLabel?.text = viewModel.getPostTitle(index: indexPath.row)
            cell.detailTextLabel?.text = viewModel.getPostBody(index: indexPath.row)
        }else{
            cell.textLabel?.text = viewModel.getFavouritePostTitle(index: indexPath.row)
            cell.detailTextLabel?.text = viewModel.getFavouritePostBody(index: indexPath.row)
        }
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.lineBreakMode = .byWordWrapping
        return cell
    }
    


}

extension PostsViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if segmentController.selectedSegmentIndex == 0{
            viewModel.addToFavourites(indexPath.row)
        }
    }
}
