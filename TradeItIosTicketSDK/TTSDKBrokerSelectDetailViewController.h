//
//  BrokerSelectDetailViewController.h
//  TradeItIosTicketSDK
//
//  Created by Antonio Reyes on 7/21/15.
//  Copyright (c) 2015 Antonio Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTSDKTicketSession.h"
#import "TradeItVerifyCredentialSession.h"
#import "TTSDKTradeItTicket.h"

@interface TTSDKBrokerSelectDetailViewController : UIViewController <UITextFieldDelegate>

@property TTSDKTicketSession * tradeSession;
@property BOOL cancelToParent;

@property NSString * addBroker;
@property TradeItAuthenticationInfo * verifyCreds;

@end
