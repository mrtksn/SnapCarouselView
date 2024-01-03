//
//  SnapCarousel.swift
//
//  Created by Mertol on 02/01/2024.
//

import SwiftUI

public struct SnapCarouselView<Item: Identifiable, ItemView: View>: View {
    public init(nextIndex: Binding<Int>, cards: [Item], @ViewBuilder viewForItem: @escaping (Int, Item) -> ItemView) {
           self._nextIndex = nextIndex
           self.cards = cards
           self.viewForItem = viewForItem
       }
    
   
    @Binding public var nextIndex: Int
    @State private var currentIndex: Int = 0
    @State private var offset : CGFloat = 0
    @State private var isDragging = false
    public let cards: [Item]
    public let viewForItem: (Int, Item) -> ItemView
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(Array(cards.enumerated()).reversed(), id:\.element.id) { index, card in
                    CarouselCardView(cardIndex: index, currentIndex: currentIndex, content: {
                        viewForItem(index, card)
                    }).frame(height: geometry.size.height)
                        .offset(x: CGFloat(index - currentIndex) * ((index < currentIndex) ? (geometry.size.width * 0.55) : (geometry.size.width * 0.2)))
                        .offset(CGSize(width: (index == currentIndex || index < currentIndex) ? self.offset * (0.2) : 0, height: 0))
                        .onTapGesture {
                            if index != currentIndex {
                                nextIndex = index
                            }
                        }
                }
            }
            .gesture(
                DragGesture()
                    .onChanged({ val in
                        //
                        isDragging = true
                        withAnimation(.spring){
                            self.offset = val.translation.width
                        }
                       
                    })
                    .onEnded { value in
                        withAnimation(.spring){
                            self.offset = 0
                        }
                       isDragging = false
                        let cardWidth = geometry.size.width * 0.3
                        let offset = value.translation.width / cardWidth
                        

                            if value.translation.width < -offset
                            {
                                nextIndex = min(currentIndex + 1, cards.count - 1)
                            } else if value.translation.width > offset {
                                nextIndex = max(currentIndex - 1, 0)
                            }
                        
                        
                    }
            )
        }
        .onChange(of: nextIndex) { newValue in
            //
            withAnimation(.spring){
                self.currentIndex = newValue
            }
        }
        .offset(CGSize(width: 50.0, height: 0))
        .padding()
    }
}


public struct CarouselCardView<Content: View>: View {
    public init(cardIndex: Int, currentIndex: Int, card: @escaping () -> Content) {
        self.cardIndex = cardIndex
        self.currentIndex = currentIndex
        self.card = card
    }
    
    
    public let cardIndex : Int
    public let currentIndex : Int
    
    public let card:() -> Content
    
    public init( cardIndex: Int, currentIndex: Int, @ViewBuilder content: @escaping () -> Content) {
        self.cardIndex = cardIndex
        self.currentIndex = currentIndex
        self.card = content
    }
    
    public var body: some View {
        GeometryReader{ geo in
                card()
                .frame(width: geo.size.width * 0.7, height: geo.size.height)
                .scaleEffect(cardIndex == currentIndex ? 1.0 : 0.9)
                .offset(x: CGFloat(self.cardIndex - currentIndex) * (geo.size.width - geo.size.width * 0.7) / 2)
        }
    }
}

