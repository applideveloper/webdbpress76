//
//  SIAPViewController.m
//  SampleInAppPurchase
//

#import "SIAPViewController.h"
#import "SIAPTransactionObserver.h"

@interface SIAPViewController ()
@end

@implementation SIAPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Notificationの登録
    NSNotificationCenter *notificationCenter =
    [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self
                           selector:@selector(paymentSucceeded:)
                               name:@"TransactionSucceeded"
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(paymentFailed:)
                               name:@"TransactionFailed"
                             object:nil];
    // プロダクト情報を取得する
    [self requireProductRequest];
}

// 成功時のNotificationを受け取る
- (void)paymentSucceeded:(NSNotification *)notification {
    SKPaymentTransaction *transaction = [notification object];
    UIAlertView *alert =
        [[UIAlertView alloc]
            initWithTitle:@"支払い成功"
                  message:[NSString stringWithFormat:
                      @"プロダクト: %@",
                      transaction.payment.productIdentifier]
                 delegate:self
        cancelButtonTitle:@"OK"
        otherButtonTitles:nil];
    
    // 実際のアプリケーションでは
    // ここで、機能の有効化やコンテンツの表示を行う
    
    [alert show];
}

// 失敗時のNotificationを受け取る
- (void)paymentFailed:(NSNotification *)notification {
    SKPaymentTransaction *transaction = [notification object];
    UIAlertView *alert =
        [[UIAlertView alloc]
         initWithTitle:@"支払い失敗"
               message:[NSString stringWithFormat:
                   @"エラー: %d",
                   transaction.error.code]
              delegate:self
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
    
    // 購入に失敗したことをユーザに通知する
    
    [alert show];
}

// プロダクト情報の取得
- (void)requireProductRequest {
    // iTunes connectに登録済みのプロダクトIDを指定する
    // 複数のプロダクトを取得する場合は複数のIDを列挙する
    NSSet *productIds =
        [NSSet setWithObjects:
            @"com.sowawa.SampleInAppPurchase.consume1", nil];
    SKProductsRequest *productRequest;
    productRequest =
        [[SKProductsRequest alloc]
            initWithProductIdentifiers:productIds];
    productRequest.delegate = self;
    [productRequest start];
}

// SKProductsRequstDelegateプロトコルの必須メソッド
- (void)productsRequest:(SKProductsRequest *)request
    didReceiveResponse:(SKProductsResponse *)response {
    for (NSString *invalidProductIdentifier in
        response.invalidProductIdentifiers) {
        // Invalidなプロダクトの場合はログを出力する
        // 現在の関数名: プロダクトID
        NSLog(@"%s: %@",
              __PRETTY_FUNCTION__, invalidProductIdentifier);
        return;
    }
    
    // ここでユーザに対してプロダクト情報等の表示を行う
    // サンプルプログラムなのでこのまま支払いに移行する
    
    // SKPaymentを作ってSKPaymentQueueに積む
    SKPayment *payment =
        [SKPayment paymentWithProduct:
            [response.products objectAtIndex:0]];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [super dealloc];
}

@end