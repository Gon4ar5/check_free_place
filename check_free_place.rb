require 'xpath'
require 'curb'
require 'nokogiri'
require 'colorize'

Pinsk = '%D0%9F%D0%B8%D0%BD%D1%81%D0%BA'
Minsk_Passangers = '%D0%9C%D0%B8%D0%BD%D1%81%D0%BA-%D0%9F%D0%B0%D1%81%D1%81%D0%B0%D0%B6%D0%B8%D1%80%D1%81%D0%BA%D0%B8%D0%B9'

while 1 do
  product_list_page_link = "https://pass.rw.by/ru/route/?from=#{Pinsk}&from_esr=&from_exp=&to=#{Minsk_Passangers}&to_esr=&to_exp=&date=#{ARGV[0]}"
  product_list_page = Nokogiri::HTML(Curl.get(product_list_page_link).body_str)
  products_info = product_list_page.xpath('//div[starts-with(@class, "sch-table__no-info")]')
  print `say "I found a ticket"` if products_info.empty?
  print '.'.green
  sleep(1)
end
