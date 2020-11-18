//
//  UIImageExtension.swift
//  GasMoney
//
//  Created by Jordan Bryant on 11/18/20.
//

import UIKit

public extension UIImage {
    
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        
        color.setFill()
        UIRectFill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        
        self.init(cgImage: cgImage)
    }
    
    func resize(newSize: CGSize) -> (UIImage) {
        let newRect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height).integral
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        
        guard let context = UIGraphicsGetCurrentContext() else { return self }
        context.interpolationQuality = CGInterpolationQuality.high
        
        let flipVertical = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: newSize.height)

        context.concatenate(flipVertical)
        context.draw(self.cgImage!, in: CGRect(x: 0.0,y: 0.0, width: newRect.width, height: newRect.height))

        guard let newImageRef = context.makeImage() else { return self }
        let newImage = UIImage(cgImage: newImageRef)

        UIGraphicsEndImageContext()

        return newImage
    }
    
}
