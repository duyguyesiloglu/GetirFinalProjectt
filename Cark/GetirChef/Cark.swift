//
//  ViewController.swift
//  Cark
//
//  Created by Duygu Yesiloglu on 9.04.2024.
//

import UIKit

class Cark: UIViewController, SpinnerViewDelegate {
    
    var spinnerView: SpinnerView!
    var wheelOverlayView: WheelOverlayView!
    var arrowImageView: UIImageView! // Ok görseli için

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "gri")
        
        spinnerView = SpinnerView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        spinnerView.center = view.center
        spinnerView.delegate = self // Delegate ataması yapılıyor
        view.addSubview(spinnerView)
        
        wheelOverlayView = WheelOverlayView(frame: CGRect(x: spinnerView.frame.origin.x, y: spinnerView.frame.origin.y - 100, width: spinnerView.bounds.width, height: 100))
        view.addSubview(wheelOverlayView)
        
        // Çarkı Döndürme/Durdurma Butonu
        let controlButton = UIButton(frame: CGRect(x: 50, y: view.frame.height - 200, width: view.frame.width - 100, height: 50))
        controlButton.backgroundColor = UIColor(named: "sari")
        controlButton.layer.cornerRadius = 15
        controlButton.setTitle("Turn - Stop", for: .normal)
        controlButton.addTarget(self, action: #selector(controlWheel), for: .touchUpInside)
        view.addSubview(controlButton)

        // Oku ekle
        setupArrowImageView()
    }
    
    func setupArrowImageView() {
        arrowImageView = UIImageView(image: UIImage(named: "ok"))
        arrowImageView.frame = CGRect(x: spinnerView.center.x - 30, y: spinnerView.frame.minY - 30, width: 60, height: 60)
        view.addSubview(arrowImageView)
    }

    @objc func controlWheel() {
        spinnerView.spin()
    }
    
    func spinnerViewDidStop(_ spinnerView: SpinnerView, selectedSegmentIndex: Int) {
       
        openPageForSegment(selectedSegmentIndex)
    }
    
    func spinnerViewDidFinishSpinning(_ spinnerView: SpinnerView, selectedSegmentIndex: Int) {
    }

    func openPageForSegment(_ segmentIndex: Int) {
        switch segmentIndex {
        case 0:
            let pageOneViewController = PizzaViewController()
            pageOneViewController.modalPresentationStyle = .pageSheet
            present(pageOneViewController, animated: true, completion: nil)
        case 1:
            let pageTwoViewController = Page3ViewController()
            pageTwoViewController.modalPresentationStyle = .pageSheet
            present(pageTwoViewController, animated: true, completion: nil)
        case 2:
            let page3ViewController = HamburgerViewController()
            page3ViewController.modalPresentationStyle = .pageSheet
            present(page3ViewController, animated: true, completion: nil)
        case 3:
            let page4ViewController = SaladViewController()
            page4ViewController.modalPresentationStyle = .pageSheet
            present(page4ViewController, animated: true, completion: nil)
        case 4:
            let page5ViewController = TacoViewController()
            page5ViewController.modalPresentationStyle = .pageSheet
            present(page5ViewController, animated: true, completion: nil)
        default:
            print("Segment için tanımlı bir ViewController yok.")
        }
    }


}
