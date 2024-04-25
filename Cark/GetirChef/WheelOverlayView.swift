//
//  WheelOverlayView.swift
//  Cark
//
//  Created by Duygu Yesiloglu on 9.04.2024.
//
import UIKit

class WheelOverlayView: UIView {
    
    let image1 = UIImage(named: "getir") // CHEF logo dosya adı varsayımıyla
    let image2 = UIImage(named: "cheff") // Getir logo dosya adı varsayımıyla

    override init(frame: CGRect) {
        super.init(frame: frame)
        addLogos()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addLogos()
    }
    
    private func addLogos() {
        let imageView1 = UIImageView(image: image1)
        let imageView2 = UIImageView(image: image2)
        
       
        imageView1.frame = CGRect(x: (self.bounds.width - 220) / 2, y: -50, width: 100, height: 50) 
        imageView2.frame = CGRect(x: imageView1.frame.maxX + 10, y: -80, width: 130, height: 90) 
        
        imageView1.contentMode = .scaleAspectFit
        imageView2.contentMode = .scaleAspectFit
        
        addSubview(imageView1)
        addSubview(imageView2)
    }
}
