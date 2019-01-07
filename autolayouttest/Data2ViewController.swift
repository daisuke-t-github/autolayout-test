//
//  Data2ViewController.swift
//  autolayouttest
//
//  Created by Daisuke-T on 2019/01/07.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class Data2ViewController: UIViewController {

	@IBOutlet weak var dataLabel: UILabel!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.dataLabel!.text = "grid"
	}


}

