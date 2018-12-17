//
//  AppDelegate.swift
//  My Vodafone
//
//  Created by Chef Dennis Barimah on 07/06/2018.
//  Copyright © 2018 Chef Dennis Barimah. All rights reserved.
//

import UIKit
import VFGSplash
import UserNotifications
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map {String(format:"%02.2hhx", $0)}.joined()
        print("token:: \(token)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        //
    }
    
    //This line will let notificatio work when app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "testIdentifier"{
            print("Go to identifier")
        }
        completionHandler()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Get the app's main bundle
        let mainBundle = Bundle.main
        
        let storyboardName = "Main"
        let viewControllerID = "ViewController"
        let targetBundle = mainBundle
        let durationInSeconds = 3
        
        runVodafoneSplash(storyboardName: storyboardName,
        viewControllerId: viewControllerID,
        targetBundle: targetBundle,
        durationInSeconds: durationInSeconds)
        
        //Push Notifications
        UNUserNotificationCenter.current().delegate = self
        
        
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            print("granted: \(granted)")
        }
        //This will register for push notification
        UIApplication.shared.registerForRemoteNotifications()
        
        FirebaseApp.configure()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func runVodafoneSplash(storyboardName storyboard: String, viewControllerId vcId: String, targetBundle bundle: Bundle, durationInSeconds timeout: Int){
        
        let nextViewController = viewControllerWith(storyboardID: storyboard,
                                                    viewControllerID: vcId,
                                                    targetBundle: bundle)
        
        playSplashAnimation(withTimeout: timeout)
        {   [weak self] in
            
            self?.moveToNext(ViewController: nextViewController)
        }
    }
    
    /*
     utility method to get a specified viewController from a target bundle
     */
    func viewControllerWith<T: UIViewController>(storyboardID storyboard: String, viewControllerID viewController: String, targetBundle bundle: Bundle) -> T{
        
        let storyboard: UIStoryboard = UIStoryboard(name: storyboard, bundle: bundle)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: viewController) as! T
        return initialViewController
    }
    
    /*
     This function plays the animation of the splash
     */
    func playSplashAnimation(withTimeout timeout: Int, onCompletion: @escaping () -> Void){
        
        //get the viewController of splash from the component
        let splashViewController = VFGAnimatedSplash.sharedInstance.returnViewController()
        
        //set it as root
        setRoot(ViewController: splashViewController)
        
        //play the animation with the given timeout
        VFGAnimatedSplash.sharedInstance.runSplashAnimationFor(timeOut: timeout)
        
        
        var image = UIImage()
        let timeOfDay = greetings()
        if timeOfDay == "morning"{
            image = UIImage(named: "morning_bg_")!
        }else if timeOfDay == "afternoon" {
            image = UIImage(named: "bg_afternoon")!
        }else{
            image = UIImage(named: "evening_bg_")!
        }
        
        let imageView = UIImageView.init(image: image)
        VFGAnimatedSplash.sharedInstance.splashInstance = splashViewController
        VFGAnimatedSplash.sharedInstance.DashBoardBackgroundImage(imageView: imageView)
        
        let xPos: CGFloat = 10
        let yPos: CGFloat = 30
        VFGAnimatedSplash.sharedInstance.setFinalLogoPosition(positionX: xPos, positionY: yPos)
        
        VFGAnimatedSplash.sharedInstance.setStatusBarStyle(statusBarStyle: .lightContent)
        
        //set your completion block which should be called once the animation finishes and the splash disappears
        VFGAnimatedSplash.sharedInstance.setComplitionHandler(completionHandler: {(completed) in
            if completed { onCompletion() }})
    }
    
    func greetings() -> String{
        var time: String = "Unknown"
        let now = Date()
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: now as Date)
        let hourInt = Int(currentHour.description)!
        if hourInt >= 0 && hourInt <= 11 {
            time = "morning"
        }else if hourInt >= 12 && hourInt <= 15 {
            time = "afternoon"
        }else{
            time = "evening"
        }
        return time
    }
    
    /*
     removes splashViewController from the root and set the root with nextViewController
     */
    func moveToNext(ViewController nextVC: UIViewController){
        VFGAnimatedSplash.sharedInstance.removeSplashView { [weak self](completed) in
            if completed {
                self?.setRoot(ViewController: nextVC)
            }
        }
    }
    
    /*
     replaces the rootView controller of your application with the given one passed in it's params.
     */
    func setRoot(ViewController viewController: UIViewController){
        
        self.window?.rootViewController = viewController
    }


}

