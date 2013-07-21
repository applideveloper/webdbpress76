def card_type(number)
  card_number = number.gsub('-','')
  {
    american_express: %r{\A3[47][0-9]{13}\Z},
    diners_club:      %r{\A3(?:0[0-5]|[68][0-9])[0-9]{11}\Z},
    discover_card:    %r{\A6(?:011|5[0-9]{2})[0-9]{12}\Z},
    jcb:              %r{\A(?:2131|1800|35\d{3})\d{11}\Z},
    master_card:      %r{\A5[1-5][0-9]{14}\Z},
    visa:             %r{\A4[0-9]{12}(?:[0-9]{3})?\Z}
  }.each do |brand, regex|
    return brand if card_number =~ regex
  end
  return :unknown
end
