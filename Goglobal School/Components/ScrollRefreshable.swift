//
//  ScrollRefreshable.swift
//  Goglobal School
//
//  Created by Leng Mouyngech on 5/9/22.
//

import SwiftUI

struct ScrollRefreshable<Content: View>: View {
    var content: Content
    var attr = [NSAttributedString.Key.foregroundColor:UIColor.systemBlue]
    init(title: String, tintColor: Color, @ViewBuilder content: @escaping ()-> Content){
        
        self.content = content()
       
        UIRefreshControl.appearance().attributedTitle = NSAttributedString(string: title,attributes: attr)
        UIRefreshControl.appearance().tintColor = UIColor(tintColor)
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
    var body: some View {
        if #available(iOS 16.0, *) {
            List{
                content
                    .listRowSeparatorTint(.clear)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .scrollContentBackground(.hidden)
            .listStyle(.plain)
            .listStyle(InsetGroupedListStyle())
        } else {
            // Fallback on earlier versions
            List{
                content
                    .listRowSeparatorTint(.clear)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .listStyle(.plain)
            .listStyle(InsetGroupedListStyle())
        }
        
    }
}

struct ScrollRefreshable_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
