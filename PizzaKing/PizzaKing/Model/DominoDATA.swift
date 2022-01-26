//
//  DominoDATA.swift
//  PizzaKing
//
//  Created by kenny on 2022/1/24.
//

import SwiftUI

struct DOMINOData: Codable{
    var DOMINO: [ItemResults]
}
struct ItemResults: Codable{
    var name: String
    var price: String
    var image: String
}

struct D_Data: View {
    
    @State var dominoDATA : DOMINOData?
    
    var body: some View{
        if let dominoDATA = dominoDATA {
            List(dominoDATA.DOMINO, id: \.name){
                item in
                Text(item.name+item.price)
                if #available(iOS 15.0, *) {
                    AsyncImage(url: URL(string: item.image), scale: 2.2)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        
        Text("Loading...")
            .onAppear(perform: self.loadData)
    }
    
    
    func loadData(){
        let urlString = "https://run.mocky.io/v3/a3ef2053-b694-4697-a1f2-0541c8fb5e9b"
        
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
                let dominoDATA = try
                JSONDecoder().decode(DOMINOData.self,from: data)
                
                DispatchQueue.main.async {
                    self.dominoDATA = dominoDATA
                }
            } catch let decodedError {
                print(decodedError.localizedDescription)
            }
        }
        task.resume()
    }
}

struct D_Data_Previews: PreviewProvider {
    static var previews: some View {
        D_Data()
    }
}
