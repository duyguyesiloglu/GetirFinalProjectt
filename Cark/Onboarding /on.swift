//
//  on.swift
//  GetirApp
//
//  Created by Duygu Yesiloglu on 24.04.2024.
//

import Foundation
import UIKit

class on: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var pages = [UIViewController]()
    var pageControl = UIPageControl()
    let nextButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        self.delegate = self

        // Initialize the onboarding pages
        let page1 = Onboarding1ViewController()
        let page2 = Onboarding2ViewController()
        let page3 = Onboarding3ViewController()
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)

        // Set the initial page
        setViewControllers([pages.first!], direction: .forward, animated: true, completion: nil)

        // Configure the page control and Next button
        configurePageControl()
        configureNextButton()
    }

    // Configure and add the Next button
    func configureNextButton() {
        let buttonWidth: CGFloat = 100
        let buttonHeight: CGFloat = 50
        let bottomMargin: CGFloat = 50
        nextButton.frame = CGRect(x: view.bounds.width - buttonWidth - 20, y: UIScreen.main.bounds.maxY - buttonHeight - bottomMargin, width: buttonWidth, height: buttonHeight)
        nextButton.layer.cornerRadius = buttonHeight / 2
        nextButton.backgroundColor = UIColor.clear
        updateButtonTitle()
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        self.view.addSubview(nextButton)
    }

    func configurePageControl() {
        let pageControlWidth: CGFloat = 150
        let pageControlHeight: CGFloat = 50
        let bottomMargin: CGFloat = 50
        pageControl = UIPageControl(frame: CGRect(x: view.bounds.width - pageControlWidth - 100 - 40, y: UIScreen.main.bounds.maxY - pageControlHeight - bottomMargin, width: pageControlWidth, height: pageControlHeight))
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.gray
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPageIndicatorTintColor = UIColor.systemGray2
        self.view.addSubview(pageControl)
    }

    func updateButtonTitle() {
        if let currentViewController = viewControllers?.first,
           let index = pages.firstIndex(of: currentViewController) {
            if index == pages.count - 1 {
                nextButton.setTitle("Get Started", for: .normal)
                nextButton.tintColor = UIColor.white
                nextButton.backgroundColor = UIColor(named: "getirmorr")
                nextButton.layer.cornerRadius = 20
            } else {
                nextButton.setTitle("Next", for: .normal)
                nextButton.tintColor = UIColor(named: "getirmorr")
            }
        }
    }

    @objc func nextButtonTapped() {
        if let currentViewController = viewControllers?.first,
           let currentIndex = pages.firstIndex(of: currentViewController) {
            if currentIndex < pages.count - 1 {
                let nextViewController = pages[currentIndex + 1]
                setViewControllers([nextViewController], direction: .forward, animated: true) {
                    finished in self.updateButtonTitle()
                }
                pageControl.currentPage = currentIndex + 1
            } else {
                transitionToMainApp()
            }
        }
    }
    
    

    func transitionToMainApp() {
        let mainAppViewController = TabController() // Create an instance of your main application view controller
        mainAppViewController.modalPresentationStyle = .fullScreen
        present(mainAppViewController, animated: true, completion: nil)
    }

    // UIPageViewControllerDataSource methods

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }

        let previousIndex = viewControllerIndex - 1
        return previousIndex >= 0 ? pages[previousIndex] : nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }

        let nextIndex = viewControllerIndex + 1
        return nextIndex < pages.count ? pages[nextIndex] : nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let pageContentViewController = pageViewController.viewControllers?.first {
                pageControl.currentPage = pages.firstIndex(of: pageContentViewController)!
            }
        }
    }
}
