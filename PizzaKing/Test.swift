//
//  Test.swift
//  PizzaKing
//
//  Created by kenny on 2022/1/18.
//

import Foundation

struct ZooCalendar: Codable {
    var result: Result
        
    struct Result: Codable {
        var results: [Result]
                
        struct Result: Codable {
            var _id: Int
            var D_Title: String
        }
    }
}

func loadData() {
    let urlString = "https://data.taipei/api/v1/dataset/87b38c72-f9e7-4f75-b3af-5b6684f2a059?scope=resourceAquire"
    
    guard let url = URL(string: urlString) else {
        print("Invalid url.")
        return
    }
    
    let request = URLRequest(url: url)
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let data = data, let _ = response else {
            print("No data or response.")
            return
        }
        
        do {
            let zooCalendar = try JSONDecoder().decode(ZooCalendar.self, from: data)
            
            DispatchQueue.main.async {
                self.zooCalendar = zooCalendar
            }
        } catch let decodingError {
            print(decodedError.localizedDescription)
        }
    }
    
    task.resume()
}
