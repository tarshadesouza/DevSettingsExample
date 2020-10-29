//
//  AppDelegate.swift
//  ExampleApp
//
//  Created by Tarsha De Souza on 27/10/2020.
//

import UIKit
import DeveloperSettings
@main
class AppDelegate: UIResponder, UIApplicationDelegate {



	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		DeveloperSettings.initialise()
		return true
	}

	// MARK: UISceneSession Lifecycle

	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		// Called when a new scene session is being created.
		// Use this method to select a configuration to create the new scene with.
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
		// Called when the user discards a scene session.
		// If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
		// Use this method to release any resources that were specific to the discarded scenes, as they will not return.
	}


}

extension UIWindow: DeveloperSettingsViewDelegate {
	open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
			if motion == .motionShake {
				DeveloperSettings.start(from: self, delegate: self)
			}
	}

	open func settingsClosed(offline: Bool, originalViewController: UIViewController?) {
		self.rootViewController = originalViewController
		checkState()
	}

	private func removeStatusBarOverlay() {
		for view in self.subviews where view.tag == 32145 {
			view.removeFromSuperview()
		}
	}

	private func addStatusBarOverlay() {
		removeStatusBarOverlay()
		var frame = self.bounds
		frame.size.height = 3
		let view = UIView(frame: frame)
		view.tag = 32145
		view.backgroundColor = .green
		view.isUserInteractionEnabled = false
		self.addSubview(view)
		self.bringSubviewToFront(view)
	}

	func checkState() {
		(DeveloperSettings.currentlyOffline) ? addStatusBarOverlay() : removeStatusBarOverlay()
	}
}


