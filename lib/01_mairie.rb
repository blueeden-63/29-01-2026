require "http"
require "nokogiri"
require "open-uri"


page = Nokogiri::HTML(URI.open("https://lannuaire.service-public.gouv.fr/navigation/ile-de-france/val-d-oise/mairie"))

all_emails_links = page.xpath('//*[@id="results-list"]/li/div/div/p//a')

mairie_name = page.xpath('//*[@id="results-list"]/li/div/div/p/a')
emails_link = page.xpath('//a[contains(@href, "mailto")]')

result = []
  all_emails_links.first(10).each_with_index do |emails_link , i|
    name_mairie = mairie_name[i]
    email = emails_link.text.strip
    name = name_mairie.text.strip
    result <<  {name => email}
  end
puts result

