//
//  ViewController.swift
//  Photo
//
//  Created by evan twidwell on 2/25/22.
//

import UIKit
import ParselyAnalytics

class ViewController: UIViewController {

    var parsely: Parsely!
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        return imageView
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Stop Engagement", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let button2: UIButton = {
        let button2 = UIButton()
        button2.backgroundColor = .gray
        button2.setTitle("Start Engagement", for: .normal)
        button2.setTitleColor(.black, for: .normal)
        return button2
    }()
    
    let colors: [UIColor] = [
        .systemBlue,
        .systemRed,
        .systemCyan,
        .systemMint,
        .systemPink,
        .systemTeal
    ]
    
    let urls: [String] = [
    "http://parselysupport.mystagingwebsite.com/tussle-with-top-seeded-shelby-awaits-polk-county-in-second-round-playoff-matchup/",
    "http://parselysupport.mystagingwebsite.com/shelbys-aerial-assault-brings-polk-countys-playoff-run-to-an-end/",
    "http://parselysupport.mystagingwebsite.com/trojans-mccombs-to-challenge-polk-in-regular-season-home-finale/",
    "https://parselysupport.mystagingwebsite.com/hill-signs-letter-of-intent-to-join-uva-wise-baseball-program/",
    "https://parselysupport.mystagingwebsite.com/beiler-surpasses-2000-yard-career-passing-mark/"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        view.addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        imageView.center = view.center
        
        view.addSubview(button)
        view.addSubview(button2)
        
        getRandomPhoto()
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button2.addTarget(self, action: #selector(didTapButton2), for: .touchUpInside)
        let rando = urls.randomElement()
        self.parsely = Parsely.sharedInstance
        self.parsely.trackPageView(url: "http://parselysupport.mystagingwebsite.com/trojans-mccombs-to-challenge-polk-in-regular-season-home-finale/")
        self.parsely.startEngagement(url: "http://parselysupport.mystagingwebsite.com/trojans-mccombs-to-challenge-polk-in-regular-season-home-finale/")
    }
    
    @objc func didTapButton(){
        getRandomPhoto()
        view.backgroundColor = colors.randomElement()
        self.parsely = Parsely.sharedInstance
        self.parsely.stopEngagement()
    }
    
    @objc func didTapButton2(){
        getRandomPhoto()
        view.backgroundColor = colors.randomElement()
        self.parsely = Parsely.sharedInstance
        self.parsely.startEngagement(url: "http://parselysupport.mystagingwebsite.com/trojans-mccombs-to-challenge-polk-in-regular-season-home-finale/")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        button.frame = CGRect(x: 30,
                              y: view.frame.size.height-150-view.safeAreaInsets.bottom,
                              width: view.frame.size.width-60,
                              height: 40)
        
        button2.frame = CGRect(x: 30,
                              y: view.frame.size.height-90-view.safeAreaInsets.bottom,
                              width: view.frame.size.width-60,
                              height: 40)
        
    }
    
    func getRandomPhoto(){
        let urlString = "https://source.unsplash.com/random/600x600"
        let url = URL(string: urlString)!
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        imageView.image = UIImage(data: data)
    }

}

