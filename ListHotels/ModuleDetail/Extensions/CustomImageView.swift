//
//  CustomImageView.swift
//  ListHotels
//
//  Created by Байсангур on 25.11.2022.
//

import UIKit
import SnapKit

final class CustomImageView: UIImageView {
    
    func loadImage(from url: URL) {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data,
                  let newImage = UIImage(data: data)
            else {
                DispatchQueue.main.async {
                    self.image = UIImage(systemName: "photo")
                }
                print("couldn't load image from URL: \(url)")
                return
            }
            DispatchQueue.main.async {
                self.image = self.cropImage(image: newImage)
            }
        }
        task.resume()
    }
    
    private func cropImage(image: UIImage) -> UIImage {
        
        let sideLengthWidth = image.size.width
        let sideLengthHeight = image.size.height
        
        let sourceSize = image.size
        let xOffset = (sourceSize.width - (sideLengthWidth - 1))
        let yOffset = (sourceSize.height - (sideLengthHeight - 1))
        
        let cropRect = CGRect(
            x: xOffset,
            y: yOffset,
            width: sideLengthWidth - 2,
            height: sideLengthHeight - 2
        ).integral
        
        let croppedCGImage = image.cgImage!.cropping(to: cropRect)!
        
        let croppedImage = UIImage(
            cgImage: croppedCGImage,
            scale: image.imageRendererFormat.scale,
            orientation: image.imageOrientation
        )
        
        return croppedImage
    }
    
}
