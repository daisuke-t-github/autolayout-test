//
//  RootViewController.swift
//  autolayouttest
//
//  Created by Daisuke-T on 2019/01/07.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UIPageViewControllerDelegate {

	var pageViewController: UIPageViewController?


	override func viewDidLoad() {
		super.viewDidLoad()

		self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
		self.pageViewController!.delegate = self

		self.pageViewController!.setViewControllers([ModelController.viewControllers()[0]],
													direction: .forward,
													animated: false,
													completion: {done in })

		self.pageViewController!.dataSource = self.modelController

		self.addChild(self.pageViewController!)
		self.view.addSubview(self.pageViewController!.view)

		self.pageViewController!.didMove(toParent: self)
	}

	var modelController: ModelController {
		if _modelController == nil {
		    _modelController = ModelController()
		}
		return _modelController!
	}

	var _modelController: ModelController? = nil

	// MARK: - UIPageViewController delegate methods

	func pageViewController(_ pageViewController: UIPageViewController, spineLocationFor orientation: UIInterfaceOrientation) -> UIPageViewController.SpineLocation {
		if (orientation == .portrait) || (orientation == .portraitUpsideDown) || (UIDevice.current.userInterfaceIdiom == .phone) {
		    // In portrait orientation or on iPhone: Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewController.SpineLocation.mid' in landscape orientation sets the doubleSided property to true, so set it to false here.
		    let currentViewController = self.pageViewController!.viewControllers![0]
		    let viewControllers = [currentViewController]
		    self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: true, completion: {done in })

		    self.pageViewController!.isDoubleSided = false
		    return .min
		}

		// In landscape orientation: Set set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
		let currentViewController = self.pageViewController!.viewControllers![0]
		var viewControllers: [UIViewController]

		let indexOfCurrentViewController = self.modelController.indexOfViewController(viewController:currentViewController)
		if (indexOfCurrentViewController == 0) || (indexOfCurrentViewController % 2 == 0) {
		    let nextViewController = self.modelController.pageViewController(self.pageViewController!, viewControllerAfter: currentViewController)
		    viewControllers = [currentViewController, nextViewController!]
		} else {
		    let previousViewController = self.modelController.pageViewController(self.pageViewController!, viewControllerBefore: currentViewController)
		    viewControllers = [previousViewController!, currentViewController]
		}
		self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: true, completion: {done in })

		return .mid
	}


}

