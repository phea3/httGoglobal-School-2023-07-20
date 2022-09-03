//
//  TooltipView.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 2/9/22.
//

import SwiftUI
import SwiftUITooltip

struct TooltipView: View {
    var tooltipConfig = DefaultTooltipConfig()
    
    init() {
        self.tooltipConfig.enableAnimation = true
        self.tooltipConfig.animationOffset = 10
        self.tooltipConfig.animationTime = 1
    }
    
    var body: some View {
        Text("Say something nice...")
            .tooltip(.bottom, config: tooltipConfig) {
                Text("Something nice!")
        }
    }
}

struct TooltipView_Previews: PreviewProvider {
    static var previews: some View {
        TooltipView()
    }
}
