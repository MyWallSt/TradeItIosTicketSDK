//
//  OrderTypeSelectionViewController.m
//  TradeItIosTicketSDK
//
//  Created by Daniel Vaughn on 12/18/15.
//  Copyright © 2015 Antonio Reyes. All rights reserved.
//

#import "TTSDKOrderTypeSelectionViewController.h"
#import "TTSDKOrderTypeInputViewController.h"

@interface TTSDKOrderTypeSelectionViewController ()

@property NSString * orderType;

@end

@implementation TTSDKOrderTypeSelectionViewController

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [UIView setAnimationsEnabled:NO];
    [[UIDevice currentDevice] setValue:@1 forKey:@"orientation"];
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [UIView setAnimationsEnabled:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tradeSession = [TTSDKTicketSession globalSession];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"OrderTypeSelectionToInput"]) {
        TTSDKOrderTypeInputViewController * dest = [segue destinationViewController];
        dest.orderType = self.orderType;
    }
}

- (IBAction)marketPressed:(id)sender {
    self.tradeSession.orderInfo.price.type = @"market";
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)limitPressed:(id)sender {
    self.orderType = @"limit";
    [self performSegueWithIdentifier:@"OrderTypeSelectionToInput" sender:self];
}

- (IBAction)stopPressed:(id)sender {
    self.orderType = @"stop";
    [self performSegueWithIdentifier:@"OrderTypeSelectionToInput" sender:self];
}

- (IBAction)stopLimitPressed:(id)sender {
    self.orderType = @"stopLimit";
    [self performSegueWithIdentifier:@"OrderTypeSelectionToInput" sender:self];
}

@end
