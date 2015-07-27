//
//  TicketController.m
//  TradeItTicketViewSDK
//
//  Created by Antonio Reyes on 7/2/15.
//  Copyright (c) 2015 Antonio Reyes. All rights reserved.
//

#import "TradeItTicketController.h"
#import "TicketSession.h"

#import "CalculatorViewController.h"
#import "LoginViewController.h"
#import "LoadingScreenViewController.h"
#import "ReviewScreenViewController.h"
#import "SuccessViewController.h"
#import "BrokerSelectViewController.h"
#import "BrokerSelectDetailViewController.h"
#import "EditScreenViewController.h"


@implementation TradeItTicketController {
    NSString * publisherApp;
    NSString* symbol;
    double lastPrice;
    UIViewController * view;
}

+(void) showFullTicketWithPublisherApp: (NSString *) publisherApp symbol:(NSString *) symbol lastPrice:(double) lastPrice viewController:(UIViewController *) view {
    [TradeItTicketController showFullTicketWithPublisherApp:publisherApp symbol:symbol lastPrice:lastPrice orderAction:@"buy" viewController:view withDebug:NO onCompletion:nil];
}

+(void) showFullTicketWithPublisherApp: (NSString *) publisherApp symbol:(NSString *) symbol lastPrice:(double) lastPrice viewController:(UIViewController *) view onCompletion:(void(^)(void)) callback {
    [TradeItTicketController showFullTicketWithPublisherApp:publisherApp symbol:symbol lastPrice:lastPrice orderAction:@"buy" viewController:view withDebug:NO onCompletion:callback];
}

+(void) debugShowFullTicketWithPublisherApp: (NSString *) publisherApp symbol:(NSString *) symbol lastPrice:(double) lastPrice viewController:(UIViewController *) view {
    [TradeItTicketController showFullTicketWithPublisherApp:publisherApp symbol:symbol lastPrice:lastPrice orderAction:@"buy" viewController:view withDebug:YES onCompletion:nil];
}


+(void) debugShowFullTicketWithPublisherApp: (NSString *) publisherApp symbol:(NSString *) symbol lastPrice:(double) lastPrice viewController:(UIViewController *) view onCompletion:(void(^)(void)) callback {
    [TradeItTicketController showFullTicketWithPublisherApp:publisherApp symbol:symbol lastPrice:lastPrice orderAction:@"buy" viewController:view withDebug:YES onCompletion:callback];
}

+(void) showFullTicketWithPublisherApp: (NSString *) publisherApp symbol:(NSString *) symbol lastPrice:(double) lastPrice orderAction:(NSString *) action viewController:(UIViewController *) view {
        [TradeItTicketController showFullTicketWithPublisherApp:publisherApp symbol:symbol lastPrice:lastPrice orderAction:action viewController:view withDebug:NO onCompletion:nil];
}

+(void) showFullTicketWithPublisherApp: (NSString *) publisherApp symbol:(NSString *) symbol lastPrice:(double) lastPrice orderAction:(NSString *) action viewController:(UIViewController *) view onCompletion:(void(^)(void)) callback {
            [TradeItTicketController showFullTicketWithPublisherApp:publisherApp symbol:symbol lastPrice:lastPrice orderAction:action viewController:view withDebug:NO onCompletion:callback];
}

+(void) showFullTicketWithPublisherApp: (NSString *) publisherApp symbol:(NSString *) symbol lastPrice:(double) lastPrice orderAction:(NSString *) action viewController:(UIViewController *) view withDebug:(BOOL) debug onCompletion:(void(^)(void)) callback {

    [TradeItTicketController forceClassesIntoLinker];
    
    //Get Resource Bundle
    NSString * bundlePath = [[NSBundle mainBundle] pathForResource:@"TradeItIosTicketSDK" ofType:@"bundle"];
    NSBundle * myBundle = [NSBundle bundleWithPath:bundlePath];
    
    //Setup ticket storyboard
    NSString * startingView = @"brokerSelectController";
    if([[TradeItTicket getLinkedBrokersList] count] > 0) {
        startingView = @"initalCalculatorController";
    }
    
    UIStoryboard * ticket = [UIStoryboard storyboardWithName:@"Ticket" bundle: myBundle];
    UIViewController * nav = (UIViewController *)[ticket instantiateViewControllerWithIdentifier: startingView];
    [nav setModalPresentationStyle: UIModalPresentationFullScreen];
    
    //Create Trade Session
    TicketSession * tradeSession = [[TicketSession alloc]initWithpublisherApp: publisherApp];
    tradeSession.orderInfo.symbol = [symbol uppercaseString];
    tradeSession.lastPrice = lastPrice;
    tradeSession.orderInfo.action = action;
    tradeSession.callback = callback;
    tradeSession.parentView = view;
    tradeSession.debugMode = debug;
    
    if([[TradeItTicket getLinkedBrokersList] count] > 0) {
        CalculatorViewController * initialViewController = [((UINavigationController *)nav).viewControllers objectAtIndex:0];
        initialViewController.tradeSession = tradeSession;
    } else {
        BrokerSelectViewController * initialViewController = [((UINavigationController *)nav).viewControllers objectAtIndex:0];
        initialViewController.tradeSession = tradeSession;
    }
    
    //Display
    [view presentViewController:nav animated:YES completion:nil];
}


- (id) initWithPublisherApp: (NSString *) publisherApp symbol:(NSString *) symbol lastPrice:(double) lastPrice viewController:(UIViewController *) view {
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}


//Let me tell you a cool story about why this is here:
//Storyboards in bundles are static, non-compilled resources
//Therefore when the linker goes through the library it doesn't
//think any of the classes setup for the storyboard are in use
//so when we actually go to load up the storyboard, it explodes
//because all those classes aren't loaded into the app. So,
//we simply call a lame method on every view class which forces
//the linker to load the classes :)
+(void) forceClassesIntoLinker {
    [CalculatorViewController class];
    [EditScreenViewController class];
    [LoginViewController class];
    [LoadingScreenViewController class];
    [ReviewScreenViewController class];
    [SuccessViewController class];
    [BrokerSelectViewController class];
    [BrokerSelectDetailViewController class];
}
@end





















