#!/usr/bin/ruby -w

require 'rubygems'
require 'nokogiri'
require 'uri'
require 'open-uri'

ULR_TO_VISIT = 'https://en.wikipedia.org/wiki/Special:Random'
URL_TO_REACH = 'https://en.wikipedia.org/wiki/Philosophie'

def get_link (url_initialized)
	count = 0 # On initialise un compteur à 0
	url_to_visit = url_initialized

	loop do
		page = Nokogiri::HTML(open(url_to_visit))
		get_href = page.xpath('//p[1]/a[1]/@href').text # href à récupérer pour creer le nouveau lien à visiter.
		title = page.css('title').text
		next_url_to_visit = "https://en.wikipedia.org#{get_href}"

		if (next_url_to_visit != url_to_visit)
			count+=1
			puts count
			puts "Site visité: #{title}"
			puts "url visité #{url_to_visit}"
			puts "url à visiter #{next_url_to_visit}"

			get_next_url_to_visit = next_visit(next_url_to_visit)
			puts get_next_url_to_visit
			url_to_visit = get_next_url_to_visit

			puts "Prochain site: #{url_to_visit}\n\n"

		else
			page = Nokogiri::HTML(open(next_url_to_visit))
			get_href = page.xpath('//p[1]/a[2]/@href')
			url_to_visit = "https://en.wikipedia.org#{get_href}"
		end

		break if url_to_visit == URL_TO_REACH
	end

	puts "\n - Scan terminé -\n
	Nombre de page visitées avant la page philosophie : #{count}\n
	Lien d'origine : #{url_to_visit}\n\n
	Essayez pour le voir de vos propres yeux --> #{url_to_visit}
	"
end

def next_visit (next_url)
	new_url = next_url
	page = Nokogiri::HTML(open(new_url))
	get_next_href = page.xpath('//p[1]/a[1]/@href').text
	get_next_url_to_visit = "https://en.wikipedia.org#{get_next_href}"
	get_next_url_to_visit


get_link(ULR_TO_VISIT)