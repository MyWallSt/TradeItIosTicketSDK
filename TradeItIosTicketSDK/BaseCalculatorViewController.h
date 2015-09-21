//
//  BaseCalculatorViewController.h
//  TradeItIosTicketSDK
//
//  Created by Antonio Reyes on 8/2/15.
//  Copyright (c) 2015 Antonio Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketSession.h"

@interface BaseCalculatorViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property TicketSession * tradeSession;

@property BOOL advMode;


-(void) setBroker;

@end
