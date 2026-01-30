require "http"
require "nokogiri"

def coin_strappeur
  response = HTTP.get("https://coinmarketcap.com/all/views/all/")
  html = response.body.to_s #transforme le fichier en string
  doc = Nokogiri::HTML(html)

  rows = doc.xpath('//table/tbody/tr')
  symboles = doc.xpath('//table/tbody/tr/td[3]/div') #la ou se trouve les symboles
  prices = doc.xpath('//table/tbody/tr/td[5]/div/span') #la ou se trouve les prices

  result = []

  symboles.each_with_index do |sym_node, i| 
    price_node = prices[i]
  # ... extraction, nettoyage, conversion, puis push dans result
    sym = sym_node.text.strip
    pr  = price_node.text.strip
    clean = pr.gsub("$", "").gsub(",", "")
    value = clean.to_f
    result <<  {sym => value}
  end
  return result
end

puts coin_strappeur
