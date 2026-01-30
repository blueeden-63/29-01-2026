require "http"
require "nokogiri"

response = HTTP.get("https://lannuaire.service-public.gouv.fr/navigation/ile-de-france/val-d-oise/mairie")
html = response.body.to_s #transforme le fichier en string
doc = Nokogiri::HTML(html)

all_emails_links = doc.xpath('//*[@id="results-list"]/li/div/div/p/a')
link = all_emails_links.get
mairie_name = doc.xpath('//*[@id="results-list"]/li/div/div/p/a')
email_link = doc.xpath('//*[@id="contentContactEmail"]/span[2]/a')

result = []
  all_emails_links.first(10).each_with_index do |all_emails_links , i|
    name_mairie = mairie_name[i]
    email = email_link.text.strip
    name = name_mairie.text.strip
    result <<  {name => email}
  end
puts result

