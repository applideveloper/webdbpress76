## 第5章 WebPayを開発しているWebアプリケーションに導入する

本ディレクトリでは、文中で紹介したコード群及びリストを含むRackアプリケーションを提供しています。
[WebPayのAPIキー](https://webpay.jp/settings)はサンプルのものを挿入しておりますが、
WebPayのWebインタフェースと合わせてお試しになる場合はご自身のものを利用してください。

Rackアプリケーションはこのディレクトリで

```
$ bundle install
$ bundle exec rackup chapter5.rb
```
を実行後に`http://localhost:9292/`にアクセスしてください。

また、WebHooksの動作を確認したい場合は、本アプリケーションをインターネット上からアクセスが可能な場所に配置して、
そのURLをWebPayにて設定してください。

Herokuへの公開も可能な状態にしています。

サンプルとして、[webdbpress76.herokuapp.com](https://webdbpress76.herokuapp.com)にも公開しております。
