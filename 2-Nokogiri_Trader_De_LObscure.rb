#!/usr/bin/ruby -w

require 'rubygems'
require 'nokogiri'
require 'open-uri'

URL_CRYPTO = 'https://coinmarketcap.com/all/views/all/'

while true

	crypto_list = []

	page = Nokogiri::HTML(open(URL_CRYPTO))
	n = page.css('#currencies-all tbody tr')

	for n in 0...page.css('#currencies-all tbody tr').length do
		crypto_list << {
			:name => page.xpath('//td[2]/a')[n].text,
			:symbol => page.xpath('//td[3]')[n].text,
			:value => page.xpath('//td[5]/a[@class="price"]')[n].text
		}
	end

	# ! { |a, b| a[:name].downcase <=> b[:name].downcase } --> classer par ordre alphabétique par nom des crypto monnaies

	crypto_list.each do |x|
		puts "#{x[:name]} -- #{x[:symbol]} -- valeur: #{x[:value]}"
	end

sleep 3600 # l'action recommence toutes les 3600 secondes comme le While est toujours vrai on ne sort pas de la boucle. 

end


      #:name => row.css('td.currency-name img')[0]["alt"],
      #:rate => row.css('td:nth-child(8)')[0]["data-usd"] || "???"

