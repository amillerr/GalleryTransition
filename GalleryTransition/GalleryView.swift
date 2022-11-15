//
//  ContentView.swift
//  GalleryTransition
//
//  Created by Artem Axenov on 2022-11-15.
//

import Introspect
import SwiftUI

struct GalleryView: View {
    
    @State var images = [
        ImageEntry(imageName: "Image_1"),
        ImageEntry(imageName: "Image_2"),
        ImageEntry(imageName: "Image_3"),
        ImageEntry(imageName: "Image_4")
    ]
    
    @StateObject var backgroundCalc = BackgroundCalc()
    
    var body: some View {
            GeometryReader { g in
                ZStack {
                    Rectangle().foregroundColor(backgroundCalc.color)
                    
                    ScrollView(.horizontal) {
                        ZStack {
                            GeometryReader { proxy in
                                let offset = proxy.frame(in: .named("scroll")).minX
                                Color.clear.preference(key: ScrollViewOffsetPreferenceKey.self, value: offset)
                            }

                            LazyHStack(spacing: 0) {
                                ForEach(images) { image in
                                    Image(uiImage: image.image)
                                        .resizable()
                                        .cornerRadius(15)
                                        .aspectRatio(contentMode: .fit)
                                        .padding(24)
                                        .frame(width: g.size.width, height: g.size.height)
                                }
                            }
                        }
                    }
                    .coordinateSpace(name: "scroll")
                    .introspectScrollView { scrollView in
                        scrollView.isPagingEnabled = true
                    }
                    .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
                        backgroundCalc.calucateBackground(position: value * -1)
                    }
                }
                .onAppear {
                    backgroundCalc.width = g.size.width
                    backgroundCalc.colors = images.map { $0.color }
                }
            }
            .ignoresSafeArea()
        }
    }

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
    }
}
