//
//  Tester.swift
//  Goglobal School
//
//  Created by loun sokphea on 18/7/23.
//

import SwiftUI
import ActivityIndicatorView

struct Tester: View {
    var body: some View {
        VStack{
            ActivityIndicatorView(isVisible: .constant(true), type: .flickeringDots(count: 8)
            )
                .frame(width: 20.0, height: 20.0)
                .foregroundColor(.blue)
            Image(systemName: "bell.fill")
                .foregroundColor(Color.blue)
                .overlay(alignment: .topTrailing) {
                        Circle()
                        .fill(.red)
                        .frame(width: 8, height: 8)
                }
        }
        .onAppear{
        }
    }
}

struct Tester_Previews: PreviewProvider {
    static var previews: some View {
        Tester()
    }
}
