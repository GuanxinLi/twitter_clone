//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

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
        print("like button selected")
        if favoriteButton.isSelected {
            if tweet.favorited! {
                print("tweet.favorited true")
                like(with: tweet)
            } else {
                unlike(with: tweet)
            }
        } else {
            print("in else")
             like(with: tweet)
        }
        
        
    }
    @IBAction func didTapRetweet(_ sender: Any) {
        print("retweet button selected")
        if retweetButton.isSelected {
            if tweet.retweeted! {
                print("tweet.favorited true")
                retweet(with: tweet)
            } else {
                disRetweet(with: tweet)
            }
        } else {
            print("in else")
            retweet(with: tweet)
        }
       
    }
    
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            favoriteCountLabel.text = String(describing: tweet.favoriteCount)
            retweetCountLabel.text = String(describing: tweet.retweetCount)
            profileImage.layer.cornerRadius = 15;
            profileImage.clipsToBounds = true;
            let iconURL = tweet.user!.iconUrl
            profileImage.af_setImage(withURL: iconURL!)
            favoriteCountLabel.text = String(tweet.favoriteCount!)
            retweetCountLabel.text = String(tweet.retweetCount!)
            //replyCountLabel.text =
            usernameLabel.text = tweet.user?.name
            screenNameLabel.text = tweet.user?.screenName
            createAtDateLabel.text = tweet.createdAtString
        }
    }
    
    func refreshData(with singleTweet: Tweet) {
        tweetTextLabel.text = singleTweet.text
        favoriteCountLabel.text = String(singleTweet.favoriteCount!)
        retweetCountLabel.text = String(singleTweet.retweetCount!)
        
        favoriteButton.isSelected = (singleTweet.favorited!) ? true : false
        
        retweetButton.isSelected = (singleTweet.retweeted!) ? true : false
    }
    
    
    func like(with tweet: Tweet) {
        print("in like tweet")
        tweet.favorited = true
        tweet.favoriteCount! += 1
        APIManager.shared.favorite(tweet, completion: { (tweet, error) in
            if let error = error {
                print("Error favoriting: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successful favorite: \(tweet.text)")
            }
        })
        favoriteButton.setImage(UIImage(named: "favor-icon-red.png"), for: .normal)
        refreshData(with: tweet)
    }
    
    func unlike(with tweet: Tweet) {
        print("in unlike tweet")
        tweet.favorited = false
        tweet.favoriteCount! -= 1
        APIManager.shared.unfavorite(tweet, completion: { (tweet, error) in
            if let error = error {
                print("Error favoriting: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successful unfavorite: \(tweet.text)")
            }
        })
        favoriteButton.setImage(UIImage(named: "favor-icon.png"), for: .normal)
        refreshData(with: tweet)
    }
    
    func retweet(with tweet: Tweet) {
        tweet.retweeted = true
        tweet.retweetCount! += 1
        APIManager.shared.retweet(tweet, completion: { (tweet: Tweet?, error: Error?) in
            if let tweet = tweet {
                self.tweet = tweet
                print("Successful retweet: \(tweet.text)")
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        })
        retweetButton.setImage(UIImage(named: "retweet-icon-green.png"), for: .normal)
        refreshData(with: tweet)
    }
    
    func disRetweet(with tweet: Tweet) {
        tweet.retweeted = false
        tweet.retweetCount! -= 1
        APIManager.shared.unretweet(tweet, completion: { (tweet: Tweet?, error: Error?) in
            if let tweet = tweet {
                self.tweet = tweet
                print("Successful unretweet: \(tweet.text)")
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        })
        retweetButton.setImage(UIImage(named: "retweet-icon.png"), for: .normal)
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
