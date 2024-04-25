//
//  SpinnerView.swift
//  Cark
//
//  Created by Duygu Yesiloglu on 9.04.2024.
//
import UIKit

protocol SpinnerViewDelegate: AnyObject {
    func spinnerViewDidFinishSpinning(_ spinnerView: SpinnerView, selectedSegmentIndex: Int)
    func spinnerViewDidStop(_ spinnerView: SpinnerView, selectedSegmentIndex: Int)
}



class SpinnerView: UIView {
    var isSpinning = false
    weak var delegate: SpinnerViewDelegate?
    
    override func draw(_ rect: CGRect) {
        
        let backgroundPath = UIBezierPath(rect: rect)
        UIColor(named: "gri")?.setFill()
        backgroundPath.fill()
        
        
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
            let radius = min(rect.width, rect.height) / 2
            let segmentAngle: CGFloat = (2 * CGFloat.pi) / 6 // Toplam 360 dereceyi 6 dilime böl

            let startColor = UIColor(hex: "4F457F")!
            let endColor = UIColor(hex: "F6D148")!
            
            for i in 0..<6 {
                let fraction = CGFloat(i) / 5 // 0'dan 1'e kadar 6 adım
                let color = UIColor.interpolate(from: startColor, to: endColor, with: fraction)
                color.setFill()

                let startAngle = segmentAngle * CGFloat(i) - .pi / 2
                let endAngle = startAngle + segmentAngle
                let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
                path.addLine(to: center)
                path.close()
                path.fill()
        }
        
     
        let images = ["1", "2", "3", "7", "5", "6"]
        let imageSize = CGSize(width: 65, height: 65)
        for i in 0..<6 {
            let midAngle = (segmentAngle * CGFloat(i) + segmentAngle * CGFloat(i + 1)) / 2 - .pi / 2
            
            // Resmin konumunu hesaplayın
            let imageRadius = radius * 0.6 // Resmin merkezden uzaklığı
            let imageX = center.x + imageRadius * cos(midAngle) - imageSize.width / 2
            let imageY = center.y + imageRadius * sin(midAngle) - imageSize.height / 2
            let imageRect = CGRect(x: imageX, y: imageY, width: imageSize.width, height: imageSize.height)
            
            if let image = UIImage(named: images[i]) {
                image.draw(in: imageRect)
            }
        }
        
    }
    

    func spin() {
        if isSpinning {
            // Çark dönüyorsa, dönmeyi durdur ve mevcut konumu koru
            let pausedTime = self.layer.convertTime(CACurrentMediaTime(), from: nil)
            self.layer.speed = 0.0
            self.layer.timeOffset = pausedTime
            isSpinning = false
        } else {
            if self.layer.speed == 0.0 {
                // Dönmeyi tekrar başlat
                let pausedTime = self.layer.timeOffset
                self.layer.speed = 1.0
                self.layer.timeOffset = 0.0
                self.layer.beginTime = 0.0
                let timeSincePause = self.layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
                self.layer.beginTime = timeSincePause
            } else {
                // Çark dönmüyorsa, dönmeye başla
                let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
                rotation.toValue = NSNumber(value: Double.pi * 2)
                rotation.duration = 1
                rotation.isCumulative = true
                rotation.repeatCount = Float.greatestFiniteMagnitude
                self.layer.add(rotation, forKey: "rotationAnimation")
            }
            isSpinning = true
        }
        let selectedSegmentIndex = Int.random(in: 0..<6) // Rastgele bir segment seçimi
            delegate?.spinnerViewDidStop(self, selectedSegmentIndex: selectedSegmentIndex)
    }

        }


extension UIColor {
    convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        let start = hex.hasPrefix("#") ? hex.index(hex.startIndex, offsetBy: 1) : hex.startIndex
        let hexColor = String(hex[start...])
        
        guard hexColor.count == 6 || hexColor.count == 8 else { return nil }
        
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        
        guard scanner.scanHexInt64(&hexNumber) else { return nil }
        
        if hexColor.count == 6 {
            r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255
            g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255
            b = CGFloat(hexNumber & 0x0000FF) / 255
            a = 1.0
        } else {
            r = CGFloat((hexNumber & 0xFF000000) >> 24) / 255
            g = CGFloat((hexNumber & 0x00FF0000) >> 16) / 255
            b = CGFloat((hexNumber & 0x0000FF00) >> 8) / 255
            a = CGFloat(hexNumber & 0x000000FF) / 255
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }

    static func interpolate(from startColor: UIColor, to endColor: UIColor, with fraction: CGFloat) -> UIColor {
        var startRed: CGFloat = 0, startGreen: CGFloat = 0, startBlue: CGFloat = 0, startAlpha: CGFloat = 0
        startColor.getRed(&startRed, green: &startGreen, blue: &startBlue, alpha: &startAlpha)
        
        var endRed: CGFloat = 0, endGreen: CGFloat = 0, endBlue: CGFloat = 0, endAlpha: CGFloat = 0
        endColor.getRed(&endRed, green: &endGreen, blue: &endBlue, alpha: &endAlpha)
        
        let red = startRed + (endRed - startRed) * fraction
        let green = startGreen + (endGreen - startGreen) * fraction
        let blue = startBlue + (endBlue - startBlue) * fraction
        let alpha = startAlpha + (endAlpha - startAlpha) * fraction
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
