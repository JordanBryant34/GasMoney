//
//  Helpers.swift
//  GasMoney
//
//  Created by Jordan Bryant on 11/18/20.
//

import Foundation
import NotificationBannerSwift

class Helpers {
    
    static func showNotificationBanner(title: String, subtitle: String, image: UIImage?, style: BannerStyle, textAlignment: NSTextAlignment) {
        var leftView: UIImageView? = nil
        
        if let image = image {
            leftView = UIImageView(image: image)
        }
        
        let notificationBanner = FloatingNotificationBanner(title: title, subtitle: subtitle, titleFont: .boldSystemFont(ofSize: 20), titleColor: .white, titleTextAlign: textAlignment, subtitleFont: .systemFont(ofSize: 17), subtitleColor: .white, subtitleTextAlign: textAlignment, leftView: leftView, rightView: nil, style: style, colors: nil, iconPosition: .center)
        
        notificationBanner.show(queuePosition: .back, bannerPosition: .top, queue: .default, on: nil, edgeInsets: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5), cornerRadius: 7.5, shadowColor: .black, shadowOpacity: 1, shadowBlurRadius: 5, shadowCornerRadius: 5, shadowOffset: .zero, shadowEdgeInsets: nil)
    }
    
}


