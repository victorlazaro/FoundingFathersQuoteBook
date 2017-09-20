//
//  QuoteViewController.swift
//  Founding Fathers Quote Book 2
//
//  Created by Victor Lazaro on 9/19/17.
//  Copyright © 2017 Victor Lazaro. All rights reserved.
//

import UIKit
import WebKit

class QuoteViewController : UIViewController {
    
    private struct Storyboard {
        static let QuoteOfTheDayTitle = "Quote of the Day"
        static let ShowTopicsSegueIdentifier = "ShowTopics"
        static let TodayTitle = "Today"
        static let TopicsTitle = "Topics"
    }
    @IBOutlet weak var webview: WKWebView!
    @IBOutlet weak var toggleButon: UIBarButtonItem!
    
    var currentQuoteIndex = 0
    var quotes: [Quote]!
    var topic: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func showQuoteOfTheDay() {
        topic = nil
        configure()
    }
    @IBAction func toggleTopics(_ sender: UIBarButtonItem) {
        if sender.title == Storyboard.TopicsTitle {
            performSegue(withIdentifier: Storyboard.ShowTopicsSegueIdentifier, sender: sender)
        }
        else {
            showQuoteOfTheDay()
        }
    }
    
    private func chooseQuoteOfTheDay() {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "DDD"
        if let dayInYear = Int(formatter.string(from: Date())) {
            currentQuoteIndex = dayInYear % QuoteDeck.sharedInstance.quotes.count
        }
    }
    
    private func configure() {
        
        if let currentTopic = topic {
            quotes = QuoteDeck.sharedInstance.quotesForTag(currentTopic)
            currentQuoteIndex = 0
        } else {
            quotes = QuoteDeck.sharedInstance.quotes
            chooseQuoteOfTheDay()
        }
        updateUI()

    }
    private func updateUI() {
        webview.loadHTMLString(quotes[currentQuoteIndex].htmlPage(), baseURL: nil)
        if let currentTopic = topic {
            toggleButon.title = Storyboard.TodayTitle
            title = "\(currentTopic.capitalized) (\(currentQuoteIndex + 1) of \(quotes.count))"
        }
        else {
            title = Storyboard.QuoteOfTheDayTitle
            toggleButon.title = Storyboard.TopicsTitle

        }
    }
    @IBAction func exitModalScene(_ segue: UIStoryboardSegue)
    {
        // Nothing to do
    }
    
    @IBAction func showTopicQuotes(_ segue: UIStoryboardSegue)
    {
        configure()
    }

}
