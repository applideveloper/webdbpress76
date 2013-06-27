//
//  SIAPAppDelegate.m
//  SampleInAppPurchase
//

#import "SIAPAppDelegate.h"
#import "SIAPTransactionObserver.h"

@implementation SIAPAppDelegate

- (void)dealloc {
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // トランザクションオブザーバを登録する
    SIAPTransactionObserver *observer =
        [SIAPTransactionObserver sharedObject];
    [[SKPaymentQueue defaultQueue]
        addTransactionObserver:observer];
    return YES;
}

- (void)applicationWillResignActive:
    (UIApplication *)application {}

- (void)applicationDidEnterBackground:
    (UIApplication *)application {}

- (void)applicationWillEnterForeground:
    (UIApplication *)application {}

- (void)applicationDidBecomeActive:
    (UIApplication *)application {}

- (void)applicationWillTerminate:
    (UIApplication *)application {}

@end
