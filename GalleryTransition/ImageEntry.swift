//
//  ImageEntry.swift
//  GalleryTransition
//
//  Created by Artem Axenov on 2022-11-15.
//

import UIKit

struct ImageEntry: Identifiable {
    let image: UIImage
    let id: UUID
    let color: UIColor
    
    init(imageName: String) {
        image = UIImage(named: imageName)!
        color = image.findAverageColor() ?? .clear
        id = UUID()
    }
}
