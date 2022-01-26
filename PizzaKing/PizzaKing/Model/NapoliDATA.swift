//
//  NapoliDATA.swift
//  PizzaKing
//
//  Created by kenny on 2022/1/24.
//

import SwiftUI

struct NapoliData: Codable{
    var Napoli: [result]
}
struct result: Codable{
    var name: String
    var price: String
    var image: String
}

struct N_Data: View {
    
    @State var napoliDATA : NapoliData?
    
    var body: some View{
        if let napoliDATA = napoliDATA {
            List(napoliDATA.Napoli, id: \.name){
                item in
                Text(item.name+item.price)
                if #available(iOS 15.0, *) {
                    AsyncImage(url: URL(string: item.image), scale: 8.5)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        
        Text("Loading...")
            .onAppear(perform: self.loadData)
    }
    
    
    func loadData(){
        let urlString = "https://run.mocky.io/v3/a1614d31-f303-4118-a3ec-f64aa88ac45e"
        
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
                let napoliDATA = try
                JSONDecoder().decode(NapoliData.self,from: data)
                
                DispatchQueue.main.async {
                    self.napoliDATA = napoliDATA
                }
            } catch let decodedError {
                print(decodedError.localizedDescription)
            }
        }
        task.resume()
    }
}

struct N_Data_Previews: PreviewProvider {
    static var previews: some View {
        N_Data()
    }
}

