//
//  ContentView.swift
//  PizzaKing
//
//  Created by kenny on 2022/1/13.
//

import SwiftUI

struct PermissionView: View {
    
    @State var isAnimating = false
    
    var animation: Animation {
        .interpolatingSpring(stiffness: 0.5, damping: 0.5)
        .repeatForever()
        .delay(isAnimating ? .random(in: 0...1) : 0)
        .speed(isAnimating ? .random(in: 0.1...1) : 0)
    }
    
    var body: some View {
        GeometryReader{ proxy in
            VStack{
                ZStack{
                    ForEach(1 ..< 15) { i in
                        Image("food\(i % 5)")
                            .position(x: .random(in: 0...proxy.size.width), y: .random(in: 0...proxy.size.height / 2)
                            )
                            .animation(animation)
                    }
                }.frame(height: proxy.size.height / 3)
            
                Text("PizzaKing")
                    .font(.title)
                
                Text("Find cool pizza to eat")
                    .font(.headline)
                
                Spacer()
                
                //按鈕
                Button{
                   
                }label:{
                    Text("Get Started")
                        .bold()
                }
                .padding()
                .frame(maxWidth: proxy.size.width - 50)
                .background(Color.red)
                .cornerRadius(50)
                .shadow(radius: 10)
                .foregroundColor(.white)
            }
        }.onAppear{
            isAnimating.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionView()
    }
}
