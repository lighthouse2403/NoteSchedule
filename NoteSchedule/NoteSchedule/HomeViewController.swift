//
//  HomeViewController.swift
//  PregnancyDiary
//
//  Created by Hai Dang Nguyen on 4/4/18.
//  Copyright © 2018 Beacon. All rights reserved.
//

import UIKit
import GoogleMobileAds

class HomeViewController: OriginalViewController, GADBannerViewDelegate, GADInterstitialDelegate {
    
    @IBOutlet weak var bannerView: GADBannerView!

    var interstitial: GADInterstitial!
    let tabController = MainTabBarViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChildViewController()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.initAdsView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Function
    func addChildViewController() {
        tabController.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChildViewController(tabController)
        self.view.addSubview(tabController.view)
        tabController.didMove(toParentViewController: self)
        
        //Add constraint
        let views: [String: Any] = ["tabView" : tabController.view, "bannerView" : bannerView]
        
        let constraint1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tabView]-0-|", options: [], metrics: nil, views: views)
        let constraint2 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[tabView]-0-[bannerView]", options: [], metrics: nil, views: views)

        var constraints = [NSLayoutConstraint]()
        constraints += constraint1
        constraints += constraint2

        NSLayoutConstraint.activate(constraints)
        app_delegate.tabBarHeight = tabController.tabBar.frame.height
    }
    
    //MARK: - Init Admob
    func initAdsView() {
        bannerView.adUnitID = kBannerAdUnitId;
        bannerView.rootViewController = self;
        bannerView.delegate = self
        bannerView.adSize = kGADAdSizeSmartBannerPortrait
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        bannerView.load(request)
        self.interstitial = createAndLoadInterstitial()
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: kInterstitialAdUnitID)
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return GADInterstitial.init(adUnitID: kInterstitialAdUnitID) //interstitial
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("load admob fail \(error.description)")
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("received admob")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
