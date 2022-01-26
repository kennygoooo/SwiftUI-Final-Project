//
//  KeelungDATA.swift
//  PizzaKing
//
//  Created by kenny on 2022/1/26.
//

import SwiftUI

struct KeelungData: Codable{
    var results: [Itemresults]
}
struct Itemresults: Codable{
    var name: String
    var vicinity: String
}

struct K_Data: View {
    
    @State var keelungDATA : KeelungData?
    
    var body: some View{
        if let keelungDATA = keelungDATA {
            List(keelungDATA.results, id: \.name){
                item in
                Text(item.name+"\n地址："+item.vicinity)
                  
            }
        }
        
        Text("Loading...")
            .onAppear(perform: self.loadData)
    }
    
    
    func loadData(){
        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=25.0338,121.5646&radius=1000000&keyword=基隆市披薩&language=zh-TW&key=AIzaSyDxYbj6iyaiDGsEfV9Ge80T-pz_86OBIYw"
        
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
                print("No data or response")
                return
            }
            
            do{
                let keelungDATA = try
                JSONDecoder().decode(KeelungData.self,from: data)
                
                DispatchQueue.main.async {
                    self.keelungDATA = keelungDATA
                }
            } catch let decodedError {
                print(decodedError.localizedDescription)
            }
        }
        task.resume()
    }
}

struct K_Data_Previews: PreviewProvider {
    static var previews: some View {
        K_Data()
    }
}
