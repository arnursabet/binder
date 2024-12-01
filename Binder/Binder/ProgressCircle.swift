//
//  ProgressCircle.swift
//  Binder
//
//  Created by Iyu Lin on 2024/11/14.
//
//still neeed to figure out randomized books

import SwiftUI

struct ProgressCircle: View {
    var progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20)
                .foregroundColor(Color("SelectorColor").opacity(0.4))
            
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(lineWidth: 20)
                .foregroundColor(Color("buttonColor"))
                .rotationEffect(.degrees(-90))
            
            Text("\(Int(progress * 100))%")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.gray)
    
            

        }
        .frame(width: 150, height: 150)
    }
}
struct ProgressCircle_Previews: PreviewProvider {
    static var previews: some View {
        ProgressCircle(progress: 0.9)
    }
}

