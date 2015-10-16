//
//  YDLandingViewController.m
//  yodafy
//
//  Created by Colin Smith on 10/15/15.
//  Copyright © 2015 Colin Smith. All rights reserved.
//

#import "YDLandingViewController.h"
#import "YDNetworkClient.h"

@interface YDLandingViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *yodafyTextField;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (weak, nonatomic) IBOutlet UIButton *yodafyMeButton;

@end

@implementation YDLandingViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.yodafyTextField.delegate = self;
    self.yodafyMeButton.layer.cornerRadius = 10;
}

#pragma mark - Button Action

- (IBAction)yodafyMeButtonWasTouched:(id)sender {
    __weak typeof(self) weakSelf = self;
    if (self.yodafyTextField.text.length > 0) {
        weakSelf.yodafyMeButton.userInteractionEnabled = NO;
        weakSelf.yodafyMeButton.alpha = 0.2;
        [[YDNetworkClient sharedClient] getYodafiedResponseWithString:weakSelf.yodafyTextField.text success:^(NSString *yodaString) {
            weakSelf.yodafyMeButton.userInteractionEnabled = YES;
            weakSelf.yodafyMeButton.alpha = 1;
            weakSelf.resultsLabel.text = yodaString;
        } failure:^(NSError *error) {
            weakSelf.yodafyMeButton.userInteractionEnabled = YES;
            
            weakSelf.resultsLabel.text = @"Sorry, the server is a jerk butt";
        }];
    }
}

@end
