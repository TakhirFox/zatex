//
//  AppDelegate.swift
//  zatex
//
//  Created by Zakirov Tahir on 05.10.2022.
//

import UIKit
import CoreData
import YandexMapsMobile
import FirebaseCore
import FirebaseMessaging
import Scyther

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configureFirebase(for: application)
        configureThirdParty()
        
        return true
    }
    
    private func configureThirdParty() {
        Appearance.apply()
        YMKMapKit.setApiKey("5cb43a37-08b8-4451-97f4-b03ea20732c4")
        YMKMapKit.sharedInstance()
        
        Scyther.instance.start()
        
        var options = DeveloperOption()
        options.name = "Стенды"
        options.viewController = ConfigurationViewController()
        
        Scyther.instance.developerOptions = [options]
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "zatex")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension AppDelegate: MessagingDelegate, UNUserNotificationCenterDelegate {
    
    func messaging(
        _ messaging: Messaging,
        didReceiveRegistrationToken fcmToken: String?
    ) {
        debugPrint("LOG: Firebase reg token \(fcmToken ?? "NON")")
        
        let isSavedDeviceToken = UserDefaults.standard.bool(forKey: "isSavedDeviceToken")
        
        if !isSavedDeviceToken {
            guard fcmToken != nil else { return }
            
            UserDefaults.standard.set(fcmToken!, forKey: "deviceToken")
            
            debugPrint("LOG: TOKEN SAVED")
        }
    }
    
    func application( // Этот метод не работает, когда есть willPresent и didReceive
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable : Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
    ) {
        debugPrint("LOG: didReceiveRemoteNotification")
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        debugPrint("LOG: willPresent")
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        debugPrint("LOG: didReceive response")
        
        if let userInfo = response.notification.request.content.userInfo as? [String: Any],
           let message = userInfo["message"] as? String {
            print("LOG: Received message: \(message)")
            
            let url = URL(string: message)
            
            if let url = url {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
        completionHandler()
    }
    
    private func configureFirebase(for application: UIApplication) {
        FirebaseApp.configure()
        
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions,
          completionHandler: { _, _ in }
        )
        
        application.registerForRemoteNotifications()
    }
    
}
