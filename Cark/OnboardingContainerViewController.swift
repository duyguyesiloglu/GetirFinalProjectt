//
//  OnboardingContainerViewController.swift
//  Cark
//
//  Created by Duygu Yesiloglu on 9.04.2024.
//

import UIKit

class OnboardingContainerViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var pages: [UIViewController] = []
    var pageControl = UIPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self

        // Onboarding sayfalarınızı oluşturun ve pages dizisine ekleyin
        // Örneğin, her sayfa için ayrı bir ViewController olmalı:
        let page1 = Onboarding1ViewController() // İlk onboarding ekranınız
        let page2 = Onboarding2ViewController() // İkinci onboarding ekranınız
        // ... diğer onboarding ekranlarınız

        // Dizilere ekleyin
        pages.append(contentsOf: [page1, page2 /* , diğerleri */ ])

        // İlk sayfayı ayarlayın
        if let firstPage = pages.first {
            setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
        }

        // Sayfa göstergesi konfigürasyonu
        configurePageControl()
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        let previousIndex = currentIndex - 1
        guard previousIndex >= 0 else { return nil }
        return pages[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        let nextIndex = currentIndex + 1
        guard nextIndex < pages.count else { return nil }
        return pages[nextIndex]
    }

    func configurePageControl() {
        // `UIPageControl`'u ekranın altında, diğer görünümlerin üzerinde olacak şekilde ayarlayın.
        pageControl = UIPageControl(frame: .init(x: 0, y: UIScreen.main.bounds.maxY - 88, width: UIScreen.main.bounds.width, height: 50))
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.backgroundColor = UIColor.clear
        self.view.addSubview(pageControl)
        self.view.bringSubviewToFront(pageControl)
    }


    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pageControl.currentPage
    }

    // Sayfa kontrolünün mevcut sayfa indexini güncellemesi için bu delegasyon metodu eklenir
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let visibleViewController = pageViewController.viewControllers?.first,
               let index = pages.firstIndex(of: visibleViewController) {
                pageControl.currentPage = index
            }
        }
    }
}
