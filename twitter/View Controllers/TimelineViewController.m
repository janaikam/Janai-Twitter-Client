//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "UIImageView+AFNetworking.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "ComposeViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *tweetsArray;
@property (weak, nonatomic) IBOutlet UITableView *timelineTableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.timelineTableView.dataSource = self;
    self.timelineTableView.delegate = self;
    
    // Get timeline
    [self getTimeline];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getTimeline) forControlEvents:UIControlEventValueChanged];
    [self.timelineTableView insertSubview:self.refreshControl atIndex:0];
}

- (IBAction)didTapLogout:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    [[APIManager shared] logout];
}

- (void)getTimeline {
    
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
            if (tweets) {
                NSLog(@"😎😎😎 Successfully loaded home timeline");
                
                self.tweetsArray = [tweets mutableCopy];
                
    //            for (NSDictionary *tweet in self.tweetsArray) {
    //                NSLog(@"%@", tweet[@"text"]);
    //            }
    //
                [self.timelineTableView reloadData];
                
    //            NSLog(@"%@", self.tweetsArray);
                
            } else {
                NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
            }
        }];
    
    [self.refreshControl endRefreshing];


    }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.delegate = self;
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    Tweet *tweet = self.tweetsArray[indexPath.row];
    cell.tweet = tweet;
    
    cell.authorLabel.text = tweet.user.name;
    cell.tweetLabel.text = tweet.text;
    cell.userLabel.text = tweet.user.screenName;
    cell.dateLabel.text = tweet.createdAtString;

    cell.likesLabel.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    cell.retweetsLabel.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    
    [cell.likeButton setSelected:tweet.favorited];
    [cell.retweetButton setSelected:tweet.retweeted];
    
    NSURL *profilePic = [NSURL URLWithString:tweet.user.profileImageURL];
    cell.authorView.image = nil;
    [cell.authorView setImageWithURL:profilePic];
    
    
    
    
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweetsArray.count;
}




- (void)didTweet:(nonnull Tweet *)tweet {
    [self.tweetsArray addObject:tweet];
    [self getTimeline];
}





@end
