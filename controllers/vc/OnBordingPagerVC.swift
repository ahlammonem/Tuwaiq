//
//  OnBordingPagerVC.swift
//  Tuwaiq
//
//  Created by ahlam on 10/01/2023.
//

import UIKit


    class OnBordingPagerVC : UIPageViewController , UIPageViewControllerDelegate , UIPageViewControllerDataSource {
      

        var arrControllers = [UIViewController]()
        var pageControl = UIPageControl()
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            delegate = self
            dataSource = self
            
            let vc1 = self.storyboard?.instantiateViewController(withIdentifier: "OnBoardingPageOneVc")
            let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "OnBoardingPageTwoVc")
            let vc3 = self.storyboard?.instantiateViewController(withIdentifier: "OnBoardingPageThreeVc")
            
            arrControllers.append(vc1!)
            arrControllers.append(vc2!)
            arrControllers.append(vc3!)
            
            
            
            if let firstVC = arrControllers.first {
                setViewControllers( [firstVC], direction: .forward, animated: true)
            }
            
            addPageControl()
        }
            func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
                
                guard let currectIndex = arrControllers.firstIndex(of: viewController) else {
                    return nil
                }
                
                let previousIndex = currectIndex - 1
                guard previousIndex >= 0 else {
                    return nil
                }
                return arrControllers[previousIndex]
            }
            
            func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
                
                guard let currectIndex = arrControllers.firstIndex(of: viewController) else {
                    return nil
                }
                
                let nextIndex = currectIndex + 1
                
                guard nextIndex < arrControllers.count else {
                    return nil
                }
                return arrControllers[nextIndex]
            }
        
        
        func addPageControl (){
            pageControl = UIPageControl (frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 200, width: UIScreen.main.bounds.width, height: 50))
            
            self.pageControl.numberOfPages = arrControllers.count
            self.pageControl.currentPage = 0
            self.pageControl.currentPageIndicatorTintColor = .systemGreen
            self.pageControl.pageIndicatorTintColor = .darkGray
            self.view.addSubview(pageControl)
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            let pageContentViewControllers = pageViewController.viewControllers![0]
            self.pageControl.currentPage = arrControllers.firstIndex(of: pageContentViewControllers)!
        }


    }


