//
//  ComposeViewController.m
//  twitter
//
//  Created by Janai Kameka on 7/1/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *composeTweetView;

@end

@implementation ComposeViewController

- (IBAction)tweetAction:(id)sender {
//    NSLog(@"%@", tweetText);
    [[APIManager shared] postStatusWithText:self.composeTweetView.text completion:^(Tweet *tweet, NSError *error){
        if (error){
            
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        } else{
            [self.delegate didTweet:tweet];
            [self dismissViewControllerAnimated:true completion:nil];
        }
    }];
    
}

- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
