# coding: utf-8
require 'bundler'
Bundler.require

Stripe.api_base = 'https://api.webpay.jp'
Stripe.api_key = 'test_secret_bkU2d8bBibZj2Iveps9sFcal'

module Chapter5
  class Application < Sinatra::Application

    get '/' do
      @customer = Stripe::Customer.all.first
      haml :index
    end

    post '/purchase_webdbpress' do
      @title = 'カード情報に対してChargeを作成する'
      @charge = Stripe::Charge.create(
        amount: 1554,
        currency: "jpy",
        description: "WEB+DB PRESSの購入",
        card: {
          number: "4242-4242-4242-4242",
          exp_month: "11",
          exp_year: "2014",
          cvc: "123",
          name: "KENGO HAMASAKI"
        }
      )
      haml :purchase_webdbpress
    end

    post '/create_customer' do
      @title = 'Customerを作成する'
      @customer = Stripe::Customer.create(
        email: 'hmsk@webpay.jp',
        description: "はまさき",
        card: {
          number: "4242-4242-4242-4242",
          exp_month: "11",
          exp_year: "2014",
          cvc: "123",
          name: "KENGO HAMASAKI"
        }
      )
      haml :create_customer
    end

    post '/purchase_webdbpress_with_customer' do
      @title = '顧客情報に対してChargeを作成する'
      @charge = Stripe::Charge.create(
        amount: 1554,
        currency: "jpy",
        description: "WEB+DB PRESSの購入",
        customer: params[:customer]
      )
      haml :purchase_webdbpress
    end

    get '/token_form' do
      @title = 'リスト1 JavaScriptでTokenを作成して送信するフォーム'
      haml :token_form
    end

    post '/purchase_webdbpress_with_token' do
      @title = 'トークンを用いてChargeを作成する'
      @charge = Stripe::Charge.create(
        amount: 1554,
        currency: "jpy",
        description: "WEB+DB PRESSの購入",
        card: params[:token]
      )
      haml :purchase_webdbpress
    end

    # リスト2 WebHooksのリクエストを受け取るエンドポイント例
    post '/webpay-webhooks' do
      data = JSON.parse(request.body.read, symbolize_names: true)
      # イベントのIDから詳細情報を取得する
      event = Stripe::Event.retrieve(data[:id])
      if event.type == 'charge.succeeded'
        if data.object.paid #=> 支払い完了したかどうか
          # メールで支払いの完了を通知する処理をここで行う
        else
          # 支払いに失敗した場合の処理をここで行う
        end
      end
      200
    end
  end
end
