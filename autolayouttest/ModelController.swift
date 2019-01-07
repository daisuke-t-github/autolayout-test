//
//  ModelController.swift
//  autolayouttest
//
//  Created by Daisuke-T on 2019/01/07.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */


class ModelController: NSObject, UIPageViewControllerDataSource {

	override init() {
	    super.init()
	}

	
	// MARK: - Utility
	static func viewControllers() -> [UIViewController]
	{
		let storyboard = UIStoryboard(name: "Main", bundle:nil)

		let res: [UIViewController] = [
			storyboard.instantiateViewController(withIdentifier: "Data1ViewController"),
			storyboard.instantiateViewController(withIdentifier: "Data2ViewController"),
			storyboard.instantiateViewController(withIdentifier: "Data3ViewController"),
			storyboard.instantiateViewController(withIdentifier: "Data4ViewController"),
		]
		
		return res;
	}
	
	func indexOfViewController(viewController:UIViewController) -> Int
	{
		let viewControllers: [UIViewController] = ModelController.viewControllers()
		var res = NSNotFound

		for i in 0..<viewControllers.count
		{
			let elm:AnyObject = viewControllers[i]
			
			if(String(describing: type(of: viewController)) != String(describing: type(of: elm)))
			{
				continue
			}
			
			res = i
			break
		}
		
		return res
	}
	
	
	
	// MARK: - Page View Controller Data Source

	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		
		let index = self.indexOfViewController(viewController: viewController)
	    if (index == 0) || (index == NSNotFound) {
	        return nil
	    }
		
		let res = ModelController.viewControllers()[index - 1]
		
		return res
	}

	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		let index = self.indexOfViewController(viewController: viewController)
	    if index == NSNotFound {
	        return nil
	    }
	    
	    if index + 1 >= ModelController.viewControllers().count {
	        return nil
	    }

		let res = ModelController.viewControllers()[index + 1]
		
		return res
	}

}

