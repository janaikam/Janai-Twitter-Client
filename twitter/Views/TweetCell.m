//
//  TweetCell.m
//  twitter
//
//  Created by Janai Kameka on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"
#import "TimelineViewController.h"

@implementation TweetCell

- (void)refreshData {
    self.likesLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.retweetsLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    [self.retweetButton setSelected:self.tweet.retweeted];
    [self.likeButton setSelected:self.tweet.favorited];
}

- (IBAction)didTapRetweet:(id)sender {
    
    [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
             NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            self.tweet.retweeted = YES;
            self.tweet.retweetCount += 1;
            [self refreshData];
        }
    }];
    

}

- (IBAction)didTapLike:(id)sender {
//    Todo: Update local tweet model

    
//    Todo: Update cell UI

    
//    Todo: Send a POST request to the POST favorites/create endpoint
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
             NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            self.tweet.favorited = YES;
            self.tweet.favoriteCount += 1;
            [self refreshData];
        }
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
