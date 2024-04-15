//
//  CustomInAppNotificationsApp.swift
//  CustomInAppNotifications
//
//  Created by Yunus Emre Berdibek on 12.11.2023.
//

import SwiftUI

@main
struct CustomInAppNotificationsApp: App {
    @State private var overlayWindow: PassThroughWindow?

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear(perform: {
                    if overlayWindow == nil {
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                            let overlayWindow = PassThroughWindow(windowScene: windowScene)
                            overlayWindow.backgroundColor = .clear
                            overlayWindow.tag = 0320
                            let controller = StatusBarBasedController()
                            controller.view.backgroundColor = .clear
                            overlayWindow.rootViewController = controller
                            overlayWindow.isHidden = false
                            overlayWindow.isUserInteractionEnabled = true
                            self.overlayWindow = overlayWindow
                        }
                    }
                })
        }
    }
}

class StatusBarBasedController: UIViewController {
    var statusBarStyle: UIStatusBarStyle = .default

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
}

private class PassThroughWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let view = super.hitTest(point, with: event) else { return nil }
        return rootViewController?.view == view ? nil : view
    }
}
