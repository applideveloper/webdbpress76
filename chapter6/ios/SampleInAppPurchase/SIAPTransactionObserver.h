//
//  SIAPTransactionObserver.h
//  SampleInAppPurchase
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@interface SIAPTransactionObserver : NSObject <SKPaymentTransactionObserver>
+ (id)sharedObject;
@end
