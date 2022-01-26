//
//  MainView.swift
//  PizzaKing
//
//  Created by kenny on 2022/1/13.
//

import SwiftUI


struct MainView: View {
    var body: some View {
        TabView{
            LogoList()
                .tabItem{
                    Label("店家", systemImage:"fork.knife.circle")
                }
            K_Data()
                .tabItem{
                    Label("地圖", systemImage:"mappin.and.ellipse")
                }
        }
        .accentColor(.red)
        
    }

}
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
