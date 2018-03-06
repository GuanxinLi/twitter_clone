//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var replyCountLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var createAtDateLabel: UILabel!
    @IBAction func didTapFavorite(_ sender: Any) {
        
        
        
    }
    @IBAction func didTapRetweet(_ sender: Any) {
        
       
    }
    
    
    var tweet: Tweet! {
        didSet {
            print("Setting up tweet cell???")
            tweetTextLabel.text = tweet.text
            favoriteCountLabel.text = tweet.favoriteCount as? String
            retweetCountLabel.text = tweet.retweetCount as? String
            //profileImage =
            //replyCountLabel.text =
            usernameLabel.text = tweet.user?.name as? String
            screenNameLabel.text = tweet.user?.screenName as? String
            createAtDateLabel.text = tweet.createdAtString
        }
    }
    
    func refreshData(with singleTweet: Tweet) {
        tweetTextLabel.text = singleTweet.text
        favoriteCountLabel.text = singleTweet.favoriteCount as? String
        retweetCountLabel.text = singleTweet.retweetCount as? String
        
        favoriteButton.isSelected = singleTweet.favorited! ? true : false
        
        retweetButton.isSelected = singleTweet.retweeted! ? true : false
    }
    
    
    func like(with tweet: Tweet) {
        tweet.favorited = true
        tweet.favoriteCount! += 1
        APIManager.shared.favorite(tweet, completion: { (tweet, error) in
            if let error = error {
                print("Error favoriting: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successful favorite: \(tweet.text)")
            }
        })
        refreshData(with: tweet)
    }
    
    func unlike(with tweet: Tweet) {
        tweet.favorited = false
        tweet.favoriteCount! -= 1
        refreshData(with: tweet)
    }
    
    func retweet(with tweet: Tweet) {
        tweet.retweeted = true
        tweet.retweetCount! += 1
        refreshData(with: tweet)
    }
    
    func disRetweet(with tweet: Tweet) {
        tweet.retweeted = false
        tweet.retweetCount! -= 1
        refreshData(with: tweet)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
