//
//  TradeItTicket.m
//  TradingTicket
//
//  Created by Antonio Reyes on 6/22/15.
//  Copyright (c) 2015 Antonio Reyes. All rights reserved.
//

#import "TTSDKTradeItTicket.h"
#import "TTSDKAccountSelectViewController.h"
#import "TTSDKTabBarViewController.h"
#import "TTSDKBrokerSelectViewController.h"
#import "TradeItAuthenticationInfo.h"
#import "TradeItConnector.h"

@implementation TTSDKTradeItTicket {

}

static NSString * kBrokerListKey = @"BROKER_LIST";
static NSString * kBrokerListViewIdentifier = @"BROKER_SELECT";
static NSString * kOnboardingViewIdentifier = @"ONBOARDING";
static NSString * kPortfolioViewIdentifier = @"PORTFOLIO";
static NSString * kTradeViewIdentifier = @"TRADE";
static NSString * kOnboardingKey = @"HAS_COMPLETED_ONBOARDING";

+(NSArray *) getAvailableBrokers {
    NSArray * brokers = @[
                          @[@"TD Ameritrade",@"TD"],
                          @[@"Robinhood",@"Robinhood"],
                          @[@"OptionsHouse",@"OptionsHouse"],
                          //@[@"Schwab",@"Schwabs"],
                          @[@"TradeStation",@"TradeStation"],
                          @[@"E*Trade",@"Etrade"],
                          @[@"Fidelity",@"Fidelity"],
                          @[@"Scottrade",@"Scottrade"],
                          @[@"Tradier Brokerage",@"Tradier"]
                          //@[@"Interactive Brokers",@"IB"]
                          ];

    

    return brokers;
}

+(NSArray *) getAvailableBrokers:(TTSDKTicketSession *) tradeSession {
    NSArray * brokers = [TTSDKTradeItTicket getAvailableBrokers];

    if([tradeSession debugMode]) {
        NSArray * dummy  =  @[@[@"Dummy",@"Dummy"]];
        brokers = [dummy arrayByAddingObjectsFromArray: brokers];
    }
    
    return brokers;
}

+(NSString *) getBrokerUsername:(NSString *) broker {
    NSDictionary *brokerUsernames = @{
                       @"Dummy":@"Username",
                       @"TD":@"User Id",
                       @"Robinhood":@"Username",
                       @"OptionsHouse":@"User Id",
                       @"Schwabs":@"User Id",
                       @"TradeStation":@"Username",
                       @"Etrade":@"User Id",
                       @"Fidelity":@"Username",
                       @"Scottrade":@"Account #",
                       @"Tradier":@"Username",
                       @"IB":@"Username",
                       };

    NSString * brokerName = [brokerUsernames valueForKey:broker];

    if (brokerName) {
        return brokerName;
    } else {
        return @"Username";
    }
}

+(NSString *) getBrokerDisplayString:(NSString *) value {
    NSArray * brokers = [TTSDKTradeItTicket getAvailableBrokers];

    for(NSArray * broker in brokers) {
        if([broker[1] isEqualToString:value]) {
            return broker[0];
        }
    }

    return value;
}

+(NSString *) getBrokerValueString:(NSString *) displayString {
    NSArray * brokers = [TTSDKTradeItTicket getAvailableBrokers];

    for(NSArray * broker in brokers) {
        if([broker[0] isEqualToString:displayString]) {
            return broker[1];
        }
    }
    
    return displayString;
}

+(NSArray *) getLinkedBrokersList {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSArray * linkedBrokers = [defaults objectForKey:kBrokerListKey];

    return linkedBrokers;
}

+(void) addLinkedBroker:(NSString *)broker {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray * linkedBrokers = [[defaults objectForKey:kBrokerListKey] mutableCopy];
    
    if(!linkedBrokers) {
        linkedBrokers = [[NSMutableArray alloc] init];
    }
    
    int i;
    for(i = 0; i < linkedBrokers.count; i++) {
        if([linkedBrokers[i] isEqualToString: broker]) {
            break;
        }
    }
    
    if(i == linkedBrokers.count) {
        [linkedBrokers addObject: broker];
    }

    [defaults setObject:linkedBrokers forKey:kBrokerListKey];
    [defaults synchronize];
}

+(void) removeLinkedBroker:(NSString *)broker {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray * linkedBrokers = [[defaults objectForKey:kBrokerListKey] mutableCopy];
    NSString * brokerToRemove;
    
    if(!linkedBrokers) {
        linkedBrokers = [[NSMutableArray alloc] init];
    }
    
    int i;
    for(i = 0; i < linkedBrokers.count; i++) {
        if([linkedBrokers[i] isEqualToString: broker]) {
            brokerToRemove = linkedBrokers[i];
            break;
        }
    }
    
    if(brokerToRemove != nil) {
        [linkedBrokers removeObject: brokerToRemove];

        [defaults setObject:linkedBrokers forKey:kBrokerListKey];
        [defaults synchronize];
    }
}

+(BOOL) isOnboarding {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSNumber * hasCompletedOnboarding = [defaults objectForKey:kOnboardingKey];

    BOOL complete = (BOOL)hasCompletedOnboarding;

    if (complete) {
        return NO;
    } else {
        [defaults setObject:@1 forKey:kOnboardingKey];
        return YES;
    }
}

+(void) storeUsername: (NSString *) username andPassword: (NSString *) password forBroker: (NSString *) broker {
    [TTSDKKeychain saveString:username forKey:[NSString stringWithFormat:@"%@Username", broker]];
    [TTSDKKeychain saveString:password forKey:[NSString stringWithFormat:@"%@Password", broker]];
}

+(TradeItAuthenticationInfo *) getStoredAuthenticationForBroker: (NSString *) broker {
    NSString * username = [TTSDKKeychain getStringForKey:[NSString stringWithFormat:@"%@Username", broker]];
    NSString * password = [TTSDKKeychain getStringForKey:[NSString stringWithFormat:@"%@Password", broker]];

    return [[TradeItAuthenticationInfo alloc] initWithId:username andPassword:password andBroker:broker];
}

+(void) showTicket:(TTSDKTicketSession *) tradeSession {
    BOOL portfolioMode = tradeSession.portfolioMode;

    //Get brokers
//    [tradeSession asyncGetBrokerListWithCompletionBlock:^(NSArray *brokerList){
//        if(brokerList == nil) {
//            tradeSession.brokerList = [TTSDKTradeItTicket getAvailableBrokers:tradeSession];
//        } else {
//            NSMutableArray * brokers = [[NSMutableArray alloc] init];
//
//            if(tradeSession.debugMode) {
//                NSArray * dummy  =  @[@"Dummy",@"Dummy"];
//                [brokers addObject:dummy];
//            }
//
//            for (NSDictionary * broker in brokerList) {
//                NSArray * entry = @[broker[@"longName"], broker[@"shortName"]];
//                [brokers addObject:entry];
//            }
//
//            tradeSession.brokerList = (NSArray *) brokers;
//        }
//    }];

    //Get Resource Bundle
    NSString * bundlePath = [[NSBundle mainBundle] pathForResource:@"TradeItIosTicketSDK" ofType:@"bundle"];
    NSBundle * myBundle = [NSBundle bundleWithPath:bundlePath];
    NSString * startingView = kBrokerListViewIdentifier;

    if([[TTSDKTradeItTicket getLinkedBrokersList] count] > 0) {
        tradeSession.resultContainer.status = USER_CANCELED;
        startingView = portfolioMode ? kPortfolioViewIdentifier : kTradeViewIdentifier;
    }

    UIStoryboard * ticket = [UIStoryboard storyboardWithName:@"Ticket" bundle: myBundle];
    UINavigationController * nav = (UINavigationController *)[ticket instantiateViewControllerWithIdentifier: @"AuthenticationNavController"];
    [nav setModalPresentationStyle:UIModalPresentationFullScreen];

    if (![self isOnboarding]) {
        TTSDKBrokerSelectViewController * initialViewController = [ticket instantiateViewControllerWithIdentifier:@"BROKER_SELECT"];
        [nav pushViewController:initialViewController animated:NO];
    }

    [tradeSession.parentView presentViewController:nav animated:YES completion:nil];
}

+(void) returnToParentApp:(TTSDKTicketSession *)tradeSession {
    [[tradeSession parentView] dismissViewControllerAnimated:NO completion:^{
        if(tradeSession.callback) {
            tradeSession.callback(tradeSession.resultContainer);
        }
    }];
}

+(void) restartTicket:(TTSDKTicketSession *) tradeSession {
    [[tradeSession parentView] dismissViewControllerAnimated:NO completion:nil];
    [TTSDKTradeItTicket showTicket:tradeSession];
}

@end


















