#!/usr/bin/ruby -w

require 'rubygems'
require 'nokogiri'
require 'open-uri'

VAL_DOISE_URL = "http://annuaire-des-mairies.com/val-d-oise.html"

def get_the_email_of_a_townhal_from_its_webpage(url)
	page = Nokogiri::HTML(open(url))
	email = page.xpath('//table/tr[3]/td/table/tr[1]/td[1]/table[4]/tr[2]/td/table/tr[4]/td[2]/p/font')
	#puts email.text
	email.text
end

def get_all_the_urls_of_val_doise_townhalls(url)
	towns_mail_list = Hash.new() #On crée un Hash vide dans lequel on va push nos infos
	page = Nokogiri::HTML(open(url)) #on ouvre la page à scrapper
	page.xpath('//table/tr[2]/td/table/tr/td/p/a').each do |town| #On boucle sur le sélecteur Xpath qu'on recheche
		town_name = town.text.downcase #On met les nom des villes en minuscules
		proper_town_name = town_name.capitalize #on rajoute une majuscule au nom (première lettre)
		town_name = town_name.split(' ').join('-') # ?
		url = "http://annuaire-des-mairies.com/95/#{town_name}.html" #ON creé l'url personnalisé pour chaques mairies dans lequel on push le nom de la mairie qu'on a scrappé
		towns_mail_list[proper_town_name.to_sym] = get_the_email_of_a_townhal_from_its_webpage(url) #On push dans le Hash les key avec .to_sym et on donne comme valeur l'email.
	end
	towns_mail_list.each do |key, value| #On boucle dans le hash qu'on a crée avec key et value et on affiche le nom de la ville et la valeur.
			print "#{key}: #{value} "
	end
end

get_all_the_urls_of_val_doise_townhalls(VAL_DOISE_URL)