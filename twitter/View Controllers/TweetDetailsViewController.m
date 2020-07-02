//
//  TweetDetailsViewController.m
//  twitter
//
//  Created by Janai Kameka on 7/2/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface TweetDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *authorView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@end

@implementation TweetDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tweetLabel.text = self.tweet.text;
    self.usernameLabel.text = self.tweet.user.name;
    self.screenNameLabel.text = self.tweet.user.screenName;
    self.dateLabel.text = self.tweet.createdAtString;
    
    self.likeCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    
    [self.likeButton setSelected:self.tweet.favorited];
    [self.retweetButton setSelected:self.tweet.retweeted];
    
    NSURL *profilePic = [NSURL URLWithString:self.tweet.user.profileImageURL];
    self.authorView.image = nil;
    [self.authorView setImageWithURL:profilePic];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
