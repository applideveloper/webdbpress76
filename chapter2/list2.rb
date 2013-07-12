def luhn(number)
  # 文字列を逆順にします
  reversed_number = number.reverse
  # 文字列を1文字ずつの配列にします
  number_charactors = reversed_number.chars
  number_charactors.each_with_index.map{|ch, index|
    if index.even?
      # 0番目から数えて偶数番目のときはそのまま数値に変換する
      ch.to_i
    else
      # 0番目から数えて奇数番目のときは
      # 2桁の数字を別々の1桁の数字として足すという処理を行う
      # （2倍した値を10で割った余りと商を足す処理で代替）
      x2 = ch.to_i * 2
      (x2) % 10 + (x2) / 10
    end
    # 最後にmapされた新しい配列にinject(:+)を適用して
    # 配列の全要素の和を求めます。
    # その結果を10で割ったときの余りが0になれば
    # チェックデジットは成功です
  }.inject(:+) % 10 == 0
end
