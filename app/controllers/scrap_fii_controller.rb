class ScrapFiiController < ApplicationController
	require 'nokogiri'
	require 'open-uri'

	def nokogiritest
		# Fetch and parse HTML document
		doc = Nokogiri::HTML(open('https://fiis.com.br/knri11'))
		items = []
		doc.css('.entry-content ul li').each do |link|
			if link.content.include? "Informou distribuição de:"
				items.push(link.content)
			end
		end
		return items
	end

	def scrapFii
		@teste = 10
		@ngiri = nokogiritest
	end
end