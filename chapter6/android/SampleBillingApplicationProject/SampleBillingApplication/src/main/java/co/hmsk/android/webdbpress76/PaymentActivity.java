package co.hmsk.android.webdbpress76;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import co.hmsk.android.webdbpress76.util.IabHelper;
import co.hmsk.android.webdbpress76.util.IabResult;
import co.hmsk.android.webdbpress76.util.Inventory;
import co.hmsk.android.webdbpress76.util.Purchase;

public class PaymentActivity extends Activity {

    private static final String
            SKU_PREMIUM = "sample_consumption_item";
    private static final String
            SKU_SUBSCRIPTION = "sample_subscription_item";
    private static final int
            REQUEST_CODE_PURCHASE_PREMIUM = 826;
    private static final String
            BILLING_PUBLIC_KEY = "";
    private IabHelper mBillingHelper;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_payment);
        mBillingHelper = new IabHelper(this, BILLING_PUBLIC_KEY);
        mBillingHelper.startSetup(
                new IabHelper.OnIabSetupFinishedListener() {
                    public void onIabSetupFinished(IabResult result) {
                        if (result.isFailure()) return;
                        mBillingHelper.queryInventoryAsync(
                                mGotInventoryListener
                        );
                    }
                }
        );
        setupButtons();
    }

    private void setupButtons() {
        ((Button) findViewById(R.id.purchase_cosumable))
                .setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        requestBilling();
                    }
                });
        ((Button) findViewById(R.id.purchase_subscription))
                .setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        requestSubscriptionBilling();
                    }
                });
        ((Button) findViewById(R.id.cancel_subscription))
                .setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        cancelSubscription();
                    }
                });
    }

    @Override
    protected void onActivityResult(
            int requestCode,
            int resultCode,
            Intent data
    ) {
        if (!mBillingHelper.handleActivityResult(
                requestCode,
                resultCode,
                data
        )) {
            super.onActivityResult(requestCode, resultCode, data);
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (mBillingHelper != null) mBillingHelper.dispose();
        mBillingHelper = null;
    }

    private IabHelper.QueryInventoryFinishedListener
            mGotInventoryListener =
            new IabHelper.QueryInventoryFinishedListener() {
                public void onQueryInventoryFinished(
                        IabResult result,
                        Inventory inventory
                ) {
                    if (result.isFailure()) return;
                    if (inventory.hasPurchase(SKU_PREMIUM)) {
                        // 購入した状態であることを確認出来た時
                    }
                    else {
                        // 購入していない状態であることを確認出来た時
                    }

                    if (inventory.hasPurchase(SKU_SUBSCRIPTION)) {
                        // 定期購読に加入済であることを確認出来た時
                    }
                    else {
                        // 定期購読に未加入であることを確認出来た時
                    }
                }
            };

    private IabHelper.OnIabPurchaseFinishedListener
            mPurchaseFinishedListener =
            new IabHelper.OnIabPurchaseFinishedListener() {
                public void onIabPurchaseFinished(
                        IabResult result,
                        Purchase purchase
                ) {
                    if (result.isFailure()) return;
                    if (purchase.getSku().equals(SKU_PREMIUM)) {
                        // 購入が完了した時
                    }
                    if (purchase.getSku().equals(SKU_SUBSCRIPTION)) {
                        // 定期購読が開始された時
                    }
                }
            };

    // 購入を実施する時にこのメソッドを実行してください
    private void requestBilling() {
        mBillingHelper.launchPurchaseFlow(
                this,
                SKU_PREMIUM,
                REQUEST_CODE_PURCHASE_PREMIUM,
                mPurchaseFinishedListener
        );
    }

    // 定期購読の開始を実施する時にこのメソッドを実行してください
    private void requestSubscriptionBilling() {
        if (mBillingHelper.subscriptionsSupported()) {
            mBillingHelper.launchSubscriptionPurchaseFlow(
                    this,
                    SKU_SUBSCRIPTION,
                    REQUEST_CODE_PURCHASE_PREMIUM,
                    mPurchaseFinishedListener
            );
        }
    }

    // 定期購読の解約を実施する時にこのメソッドを実行してください
    private void cancelSubscription() {
        startActivity(
            new Intent(
                        Intent.ACTION_VIEW,
                        Uri.parse("market://details?id=" + getPackageName())
                )
        );
    }
}
