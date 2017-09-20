//
//  TopicsViewController.swift
//  Founding Fathers Quote Book 2
//
//  Created by Victor Lazaro on 9/20/17.
//  Copyright © 2017 Victor Lazaro. All rights reserved.
//

import UIKit

class TopicsViewController : UITableViewController {
    
    private struct Storyboard {
        static let ShowQuoteSegueIdentifier = "ShowQuote"
        static let TopicCellIdentifier = "TopicCell"
    }
    
    var selectedTopic: String?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? QuoteViewController {
            destinationVC.topic = selectedTopic
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QuoteDeck.sharedInstance.tagSet.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.TopicCellIdentifier,
                                                 for: indexPath)
        cell.textLabel?.text = QuoteDeck.sharedInstance.tagSet[indexPath.row].capitalized
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTopic = QuoteDeck.sharedInstance.tagSet[indexPath.row]
        performSegue(withIdentifier: Storyboard.ShowQuoteSegueIdentifier, sender: self)
    }
}
