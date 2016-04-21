//
//  BaseCalculatorViewController.h
//  TradeItIosTicketSDK
//
//  Created by Antonio Reyes on 8/2/15.
//  Copyright (c) 2015 Antonio Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTSDKTradeItTicket.h"
#import "TTSDKUtils.h"
#import "TradeItPreviewTradeRequest.h"
#import "TradeItPreviewTradeResult.h"
#import "TTSDKPortfolioAccount.h"
#import "TTSDKViewController.h"

@interface TTSDKBaseTradeViewController : TTSDKViewController

@property TradeItResult * lastResult;

@property NSArray * questionOptions;
@property NSDictionary * currentAccount;
@property TTSDKPortfolioAccount * currentPortfolioAccount;

-(void) sendPreviewRequest;

-(void) acknowledgeAlert;
-(void) retrieveQuoteData;
-(void) retrieveAccountSummaryData;

@end
