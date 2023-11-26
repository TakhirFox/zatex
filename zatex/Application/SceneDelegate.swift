//
//  SceneDelegate.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.10.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var application: ApplicationCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        self.window = window
        self.window?.windowScene = windowScene
        
        application = ApplicationCoordinator()
        application?.start(window)
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        
        if let scheme = url.scheme,
           scheme.localizedCaseInsensitiveCompare("zatexmobile") == .orderedSame,
           let view = url.host
        {
            var parameters: [String: Int] = [:]
            
            URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?.forEach {
                parameters[$0.name] = Int($0.value ?? "")
            }
            
            switch view {
            case "product":
                application?.showDeeplink(
                    deeplinkType: .product(id: parameters.first?.value ?? 0)
                )
                
            case "profile":
                application?.showDeeplink(
                    deeplinkType: .profile(id: parameters.first?.value ?? 0)
                )
                
            case "chats":
                application?.showDeeplink(
                    deeplinkType: .chat(id: String(parameters.first?.value ?? 0))
                )
                
            default:
                return
            }
        }
    }
}
