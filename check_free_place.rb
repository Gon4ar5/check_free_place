require 'xpath'
require 'curb'
require 'nokogiri'
require 'colorize'

user_agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2'.freeze
Pinsk = '%D0%9F%D0%B8%D0%BD%D1%81%D0%BA'.freeze
Minsk_Passangers = '%D0%9C%D0%B8%D0%BD%D1%81%D0%BA-%D0%9F%D0%B0%D1%81%D1%81%D0%B0%D0%B6%D0%B8%D1%80%D1%81%D0%BA%D0%B8%D0%B9'.freeze

loop do
  rw_by_link = "https://pass.rw.by/ru/route/?from=#{Minsk_Passangers}&from_esr=&from_exp=&to=#{Pinsk}&to_esr=&to_exp=&date=#{ARGV[0]}"
  rw_by_page = Nokogiri::HTML(Curl.get(rw_by_link).body_str)
  price_div = rw_by_page.xpath('//div[starts-with(@class, "sch-table__cell cell-4 empty")]') # if u can see empty space under price
  seats_div = rw_by_page.xpath('//div[starts-with(@class, "sch-table__no-info")]') # if u can see 'Мест нет' under price
  span_number_with_train_exist = rw_by_page.xpath('//span[starts-with(@class, "train-number")]')&.first&.children&.to_s == "859Б" # train with this number exist on page
  print `say "I found a ticket"` if price_div.empty? && seats_div.empty? && span_number_with_train_exist
  print '.'.green
  sleep(1)
end
