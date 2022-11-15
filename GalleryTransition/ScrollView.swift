//
//  ScrollView.swift
//  GalleryTransition
//
//  Created by Artem Axenov on 2022-11-15.
//

import SwiftUI

ScrollView (.horizontal) {
    ZStack {
        GeometryReader { proxy in
            let offset = proxy.frame(in: .named("scroll")).minX
            Color.clear.preference(key: ScrollViewOffsetPreferenceKey.self, value: offset)
        }
        
        LazyHStack (spacing: 0) {
            ForEach(images) { image in
                Image(uiImage: image.image)
                    .resizable()
                    .cornerRadius(10)
                    .aspectRatio(contentMode: .fit)
                    .padding(24)
                    .frame(width: g.size.width, height: g.size.height)
            }
        }
    }
}
.coordinateSpace(name: "scroll")
.introspectScrollView { ScrollView in
    ScrollView.isPagingEnabled = true
}
.onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
    print("offse: \(value)")
}
