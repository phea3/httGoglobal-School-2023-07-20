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
        ActivityIndicatorView(isVisible: .constant(true), type: .rotatingDots(count: 5))
             .frame(width: 50.0, height: 50.0)
             .foregroundColor(.blue)
    }
}

struct Tester_Previews: PreviewProvider {
    static var previews: some View {
        Tester()
    }
}
