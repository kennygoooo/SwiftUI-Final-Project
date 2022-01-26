//
//  LogoList.swift
//  PizzaKing
//
//  Created by kenny on 2022/1/19.
//

import SwiftUI

struct Logo:Identifiable{
    var id: String{ name }
    let name: String
}

struct LogoList: View {
    let logos = [
        Logo(name: "必勝客"),
        Logo(name: "達美樂"),
        Logo(name: "拿坡里")]
    var body: some View {
        NavigationView {
            List {
                NavigationLink{
                    HutData()
                }label:{
                    LogoRow(logo: logos[0])
                }
                NavigationLink{
                    D_Data()
                }label:{
                    LogoRow(logo: logos[1])
                }
                NavigationLink{
                    D_Data()
                }label:{
                    LogoRow(logo: logos[2])
                }
            }
            .navigationTitle("比薩店")
            
        }
    }
}

//NavigationLink("View 3", destination: View3())

struct LogoRow:View{
    
    let logo: Logo
    var body: some View{
        HStack{
            Image(logo.name)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .shadow(radius: 3)
                .clipped()
            Text(logo.name)
            Spacer()
        }
    }
}

struct LogoList_Previews: PreviewProvider {
    static var previews: some View {
        LogoList()
    }
}
