//
//  BaseCalculatorViewController.h
//  TradeItIosTicketSDK
//
//  Created by Antonio Reyes on 8/2/15.
//  Copyright (c) 2015 Antonio Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTSDKTicketSession.h"
#import "TTSDKCustomIOSAlertView.h"
#import "TTSDKUtils.h"
#import "TTSDKTicketController.h"

@interface TTSDKBaseTradeViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property TTSDKTicketSession * tradeSession;
@property TradeItResult * lastResult;
//@property TradeItStockOrEtfTradeReviewResult * reviewResult;
//@property TradeItStockOrEtfTradeSuccessResult * successResult;

@property BOOL advMode;
@property NSArray * pickerTitles;
@property NSArray * pickerValues;
@property UIPickerView * currentPicker;
@property NSString * currentSelection;
@property NSArray * questionOptions;
@property NSDictionary * currentAccount;

@property TTSDKUtils * utils;
@property TTSDKTicketController * globalController;

-(void) setBroker;
-(void) sendLoginReviewRequest;
-(void) showOldErrorAlert: (NSString *) title withMessage:(NSString *) message;
//-(void) showOldAcctSelect: (TradeItMultipleAccountResult *) multiAccountResult;
-(void) showOldSecQuestion:(NSString *) question;
//-(void) showOldMultiSelect:(TradeItSecurityQuestionResult *) securityQuestionResult;
-(void) showOldOrderAction;
-(void) showOldOrderExp;
-(UIView *) createPickerView;
-(UIView *) createPickerView: (NSString *) title;
-(void) acknowledgeAlert;

@end
