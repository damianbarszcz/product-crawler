require 'watir'
require 'webdrivers'
require 'Nokogiri'
require 'csv'

browser  = Watir::Browser.new

browser.goto("https://www.amazon.com/s?bbn=16225007011&rh=n%3A16225007011%2Cn%3A172456&dc&qid=1644954436&rnid=16225007011&ref=lp_16225007011_nr_n_0")

parse_page = Nokogiri::HTML(browser.html)

products_array = []

parse_page.css('.s-main-slot').css('.s-result-item').map do |a|
        title =  "Title: " +  a.css('.a-size-base-plus').text
        price = "Price: " + a.css('.a-offscreen').text
        products_array.push(title)
        products_array.push("\n")
        products_array.push(price)
        products_array.push("\n\n")
end


CSV.open('products.csv', 'w') do  |csv|
        csv << products_array 
end