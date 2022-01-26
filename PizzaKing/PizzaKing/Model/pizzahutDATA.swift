//
//  pizzahutDATA.swift
//  PizzaKing
//
//  Created by kenny on 2022/1/24.
//

import SwiftUI

struct PizzaHutData: Codable{
    var PizzaHut: [Result]
}
struct Result: Codable{
    var name: String
    var price: String
    var image: String
}

struct HutData: View {
    
    @State var pizzaHutData : PizzaHutData?
    
    var body: some View{
        if let pizzaHutData = pizzaHutData {
            List(pizzaHutData.PizzaHut, id: \.name){
                item in
                Text(item.name+item.price)
                if #available(iOS 15.0, *) {
                    AsyncImage(url: URL(string: item.image))
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        
        Text("Loading...")
            .onAppear(perform: self.loadData)
    }
    
    
    func loadData(){
        let urlString = "https://run.mocky.io/v3/b8ad94bb-3758-4af8-a7ca-2328990c9cdb"
        
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
                let pizzaHutData = try
                JSONDecoder().decode(PizzaHutData.self,from: data)
                
                DispatchQueue.main.async {
                    self.pizzaHutData = pizzaHutData
                }
            } catch let decodedError {
                print(decodedError.localizedDescription)
            }
        }
        task.resume()
    }
}

struct HutData_Previews: PreviewProvider {
    static var previews: some View {
        HutData()
    }
}
