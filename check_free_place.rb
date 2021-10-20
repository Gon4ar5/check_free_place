require 'xpath'
require 'curb'
require 'nokogiri'
require 'colorize'

Pinsk = '%D0%9F%D0%B8%D0%BD%D1%81%D0%BA'
Minsk_Passangers = '%D0%9C%D0%B8%D0%BD%D1%81%D0%BA-%D0%9F%D0%B0%D1%81%D1%81%D0%B0%D0%B6%D0%B8%D1%80%D1%81%D0%BA%D0%B8%D0%B9'

loop do
  rw_by_link = "https://pass.rw.by/ru/route/?from=#{Pinsk}&from_esr=&from_exp=&to=#{Minsk_Passangers}&to_esr=&to_exp=&date=#{ARGV[0]}"
  rw_by_page = Nokogiri::HTML(Curl.get(rw_by_link).body_str)
  cell_with_no_seats = rw_by_page.xpath('//div[starts-with(@class, "sch-table__cell cell-4 empty")]')
  print `say "I found a ticket"` if cell_with_no_seats.empty?
  print '.'.green
  sleep(1)
end
