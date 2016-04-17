//
//  TTSDKStyles.m
//  TradeItIosTicketSDK
//
//  Created by Daniel Vaughn on 4/7/16.
//  Copyright © 2016 Antonio Reyes. All rights reserved.
//

#import "TTSDKStyles.h"

@interface TTSDKStyles() {
    UIColor * etradeColor;
    UIColor * robinhoodColor;
    UIColor * schwabColor;
    UIColor * scottradeColor;
    UIColor * fidelityColor;
    UIColor * tdColor;
    UIColor * optionshouseColor;
}

@end

@implementation TTSDKStyles

+ (id)sharedStyles {
    static TTSDKStyles *sharedStylesInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStylesInstance = [[self alloc] init];
    });
    
    return sharedStylesInstance;
}

- (id)init {
    if (self = [super init]) {

        // State
        self.warningColor = [UIColor colorWithRed:236.0f/255.0f green:121.0f/255.0f blue:31.0f/255.0f alpha:1.0f];
        self.lossColor = [UIColor colorWithRed:200.0f/255.0f green:22.0f/255.0f blue:0.0f alpha:1.0f];

        self.gainColor = [UIColor colorWithRed:0.0f green:200.0f/255.0f blue:22.0f/255.0f alpha:1.0f];

        self.activeColor = [UIColor colorWithRed:38.0f/255.0f green:142.0f/255.0f blue:255.0f/255.0f alpha:1.0];
        self.inactiveColor = [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0f];

        // Text
        self.primaryTextColor = [UIColor colorWithRed:20.0f/255.0f green:20.0f/255.0f blue:20.0f/255.0f alpha:1.0];
        self.primaryTextHighlightColor = [UIColor colorWithRed:180.0f/225.0f green:180.0f/225.0f blue:180.0f/225.0f alpha:1.0f];
        self.smallTextColor = [UIColor lightGrayColor];
        self.primaryPlaceholderColor = self.inactiveColor;

        // UI Elements
        self.primarySeparatorColor = [UIColor lightGrayColor];
        self.tabBarBackgroundColor = nil;
        self.tabBarItemColor = self.activeColor;
        self.switchColor = self.gainColor;
        self.pageBackgroundColor = [UIColor whiteColor];
        self.navigationBarBackgroundColor = [UIColor colorWithRed:247.0f/255.0f green:247.0f/255.0f blue:247.0f/255.0f alpha:1.0];
        self.navigationBarItemColor = nil;
        self.navigationBarTitleColor = self.primaryTextColor;

        // UI Elements - loading
        self.loadingBackgroundColor = [UIColor whiteColor];
        self.loadingIconColor = self.inactiveColor;

        // Set default styles for primary active button
        self.primaryActiveButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        self.primaryActiveButton.backgroundColor = self.activeColor;
        self.primaryActiveButton.layer.borderColor = [UIColor clearColor].CGColor;
        self.primaryActiveButton.layer.borderWidth = 0.0f;
        self.primaryActiveButton.layer.cornerRadius = 22.0f;
        self.primaryActiveButton.layer.masksToBounds = NO;
        self.primaryActiveButton.layer.shadowColor = [UIColor colorWithRed:40.0f/255.0f green:40.0f/255.0f blue:40.0f/255.0f alpha:1.0f].CGColor;
        self.primaryActiveButton.layer.shadowOpacity = 0.4;
        self.primaryActiveButton.layer.shadowRadius = 1;
        self.primaryActiveButton.layer.shadowOffset = CGSizeMake(0,1);
        [self.primaryActiveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        // Set default styles for primary inactive button
        self.primaryInactiveButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        self.primaryInactiveButton.backgroundColor = self.inactiveColor;
        self.primaryInactiveButton.layer.borderColor = [UIColor clearColor].CGColor;
        self.primaryInactiveButton.layer.borderWidth = 0.0f;
        self.primaryInactiveButton.layer.cornerRadius = 22.0f;
        self.primaryInactiveButton.layer.shadowColor = [UIColor clearColor].CGColor;
        self.primaryInactiveButton.layer.shadowOpacity = 0;
        [self.primaryInactiveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        // Set default styles for preferred broker button (only shown on onboarding screen)
        self.preferredBrokerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];

        // Brokers
        etradeColor = [UIColor colorWithRed:98.0f / 255.0f green:77.0f / 255.0f blue:160.0f / 255.0f alpha:1.0f];
        robinhoodColor = [UIColor colorWithRed:33.0f / 255.0f green:206.0f / 255.0f blue:153.0f / 255.0f alpha:1.0f];
        schwabColor = [UIColor colorWithRed:25.0f / 255.0f green:159.0f / 255.0f blue:218.0f / 255.0f alpha:1.0f];
        scottradeColor = [UIColor colorWithRed:69.0f / 255.0f green:40.0f / 255.0f blue:112.0f / 255.0f alpha:1.0f];
        fidelityColor = [UIColor colorWithRed:74.0f / 255.0f green:145.0f / 255.0f blue:46.0f / 255.0f alpha:1.0f];
        tdColor = [UIColor colorWithRed:2.0f / 255.0f green:182.0f / 255.0f blue:36.0f / 255.0f alpha:1.0f];
        optionshouseColor = [UIColor colorWithRed:46.0f / 255.0f green:98.0f / 255.0f blue:9.0f / 255.0f alpha:1.0f];
    }

    return self;
}

-(UIColor *) retrieveTdColor {
    return tdColor;
}

-(UIColor *) retrieveEtradeColor {
    return etradeColor;
}

-(UIColor *) retrieveSchwabColor {
    return schwabColor;
}

-(UIColor *) retrieveFidelityColor {
    return fidelityColor;
}

-(UIColor *) retrieveRobinhoodColor {
    return robinhoodColor;
}

-(UIColor *) retrieveScottradeColor {
    return scottradeColor;
}

-(UIColor *) retrieveOptionsHouseColor {
    return optionshouseColor;
}


@end
