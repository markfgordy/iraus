class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    rootViewController = DiscountController.alloc.initWithNibName(nil, bundle: nil)
    navigationController = UINavigationController.alloc.initWithRootViewController(rootViewController)

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = navigationController
    @window.makeKeyAndVisible

    UIBarButtonItem.appearance.tintColor = UIColor.colorWithRed(0.9400, green:0.9400, blue:0.9400, alpha: 1)

    navigationController.navigationBarHidden = true
    navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent

    true
  end
end