//
//  Example.swift
//  SnapCarouselView
//
//  Created by Mertol on 04/01/2024.
//

import SwiftUI
import SnapCarouselView


/*
 A quick demonstration of how to use the SnapCarouselView
 */
struct ContentView : View {
    
    //You need some kind of Identifiable data that will be used to generate the cards
    @State var items : [ExampleItemModel] = [.init(color: Color.yellow, text: "item 1"), .init(color: Color.cyan, text: "item 2"), .init(color: Color.purple, text: "item 3"), .init(color: Color.black, text: "item 4")]
    
    //You can track and set the index
    @State var index = 0
    
    var body: some View {
        
        //Next index is called next because when changed then triggers current index change
        SnapCarouselView(nextIndex: self.$index, cards: self.items) { itemIndex, item in
            //SnapCarouselView will loop through your data and give you the opportunity to create a View for each one of it.
            //itemIndex is the index of the item in the loop, item is the item itself.
            //You can customize each page/card here. For example, you can check if this is the selected one by itemIndex == self.index and then apply the style you want.
            ZStack{
                RoundedRectangle(cornerRadius: 25)
                    .fill(item.color)
                    .padding()
                    .overlay(Circle().fill(Color.white))
                Text(item.text)
            }
        }
        .padding(.top)
        .frame(height: 300)
    }
}

struct ExampleItemModel : Identifiable {
    let id = UUID()
    let color : Color
    let text : String
}
