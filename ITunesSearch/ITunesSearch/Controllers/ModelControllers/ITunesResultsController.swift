//
//  ITunesResultsController.swift
//  ITunesSearch
//
//  Created by William Moody on 5/16/19.
//  Copyright © 2019 William Moody. All rights reserved.
//

import UIKit


class ITunesResultsController {
    
    static let baseURL = URL(string: "https://itunes.apple.com")
    
    static func searchItunesFor(searchTerm: String, completion: @escaping ([ITunesResults]) -> Void) {
      
        //build URL
        //getting base url
        guard var url = baseURL else {completion([]); return}
        //appending coponents
        url.appendPathComponent("search")
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        let termQuerry = URLQueryItem(name: "term", value: searchTerm)
        let musicQuerry = URLQueryItem(name: "media", value: "music")
        
        components?.queryItems = [termQuerry, musicQuerry]
        
        guard let finalURL = components?.url else { completion([]); return}
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                print("🎆🎆🎆🎆🎆Problem with itunessearch datatask🎆🎆🎆🎆🎆🎆")
            }
            
            guard let data = data else {completion([]); return}
            
            let decoder = JSONDecoder()
            do{
                
                let topLevelJSON = try decoder.decode(TopLevelJson.self, from: data)
                
                let itunesResults = topLevelJSON.results
                completion(itunesResults)
                
            }catch{
                print("Problem decoding itunes search🎆🎆🎆🎆🎆🎆🎆 \(error.localizedDescription)")
                completion([])
                return
            }
            
        }.resume()
    }
    
    static func fetchImageFor(iTunesItem: ITunesResults, completion: @escaping (UIImage?) -> Void) {
        
        guard let url = iTunesItem.imageURL else{ completion(nil); return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error fetching image for itunes result \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {completion(nil); return}
            
            let image = UIImage(data: data)
            completion(image)
        }
    }
}
