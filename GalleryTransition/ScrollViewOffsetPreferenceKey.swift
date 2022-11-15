//
//  ScrollViewOffsetPreferenceKey.swift
//  GalleryTransition
//
//  Created by Artem Axenov on 2022-11-15.
//

import SwiftUI

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: CGFloat = .zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
