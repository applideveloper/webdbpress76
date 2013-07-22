WebPay.setPublishableKey(
    'test_public_62W08o3YN0mj5T88953A34mZ');
var webpayResponseHandler = function(status, response) {
  var form = $("#payment-form");
  if (response.error) {
    // 必要に応じてエラー処理を入れてください
    form.find('button').prop('disabled', false);
    console.log(response);
  } else {
    // 伝送させたくない情報をフォームから削除する
    $(".card-number").removeAttr("name");
    $(".card-cvc").removeAttr("name");
    $(".card-expiry-year").removeAttr("name");

    var token = response.id;

    var input = document.createElement('input');
    input.type = 'hidden';
    input.name = 'token';
    input.value = token;
    $(input).appendTo(form);
    form.get(0).submit();
  }
};

jQuery(function($) {
  $('#payment-form').submit(function(e) {
    var form = $(this);
    form.find('button').prop('disabled', true);
    WebPay.createToken({
      number: form.find(".card-number").val(),
      name: form.find(".card-name").val(),
      cvc: form.find(".card-cvc").val(),
      exp_month: form.find(".expiry-month").val(),
      exp_year: "20" + form.find(".expiry-year").val()
    }, webpayResponseHandler);
    e.preventDefault();
  });
});
