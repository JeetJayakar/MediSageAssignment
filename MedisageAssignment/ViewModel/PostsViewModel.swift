//
//  PostsViewModel.swift
//  MedisageAssignment
//
//  Created by Jeet Jaykar on 24/09/21.
//

import Foundation


class PostsViewModel {
    
    var postsArray = [PostElement]()
    var favouritePostsArray = [PostElement]()
    var updateData : (Bool)->Void = {_ in }
    
    func fetchAllPosts()  {
        
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)) { data, response, error in
            
            if error != nil{
                self.getPostsArray()
            }else if let data  = data,let json = String(data: data, encoding: .utf8){
                
                do {
                    self.postsArray = try Post(json)
                    self.updateData(true)
                    self.savePostsArray()
                } catch  {
                    self.updateData(false)
                }
            }
            
            
        }.resume()
    }
    
    func savePostsArray()  {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(postsArray) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "LocalPostsData")
        }
    }
    
    func getPostsArray()  {
        let defaults = UserDefaults.standard
        if let savedPostData = defaults.object(forKey: "LocalPostsData") as? Data {
            let decoder = JSONDecoder()
            if let savedPostArray  = try? decoder.decode([PostElement].self, from: savedPostData) {
                postsArray = savedPostArray
                updateData(true)
            }
        }
    }
    
    func addToFavourites(_ index : Int)  {
        favouritePostsArray.append(postsArray[index])
    }
    
    
    func getAllPostsCount() -> Int {
        return postsArray.count
    }
    
    func getPostTitle(index : Int) -> String {
        return postsArray[index].title
    }
    
    func getPostBody(index : Int) -> String {
        return postsArray[index].body
    }
    
    
    func getFavouritePostCount() -> Int {
        return favouritePostsArray.count
    }
    
    func getFavouritePostTitle(index : Int) -> String {
        return favouritePostsArray[index].title
    }
    
    func getFavouritePostBody(index : Int) -> String {
        return favouritePostsArray[index].body
    }
    
}
