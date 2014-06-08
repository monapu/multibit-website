
require 'fileutils'
require 'nokogiri'

ORIG_DIR = "../src/main/resources/views/html/en/help/v0.5"
ORIG_IMG_DIR = "../src/main/resources/assets/images/en/v0_5"
NEW_DIR  = "help/en/converted"

FileUtils.mkdir_p NEW_DIR
files = Dir.glob(ORIG_DIR + "/*.html")
# files = ARGV

files.each{|path|
  html = File.read( path )
  h = Nokogiri::HTML(html)
  
  h.search("img").each{|img| img['src'] = img['src'].sub(/\/images\/en\/v0_\d\//,'img/')}
  h.search("a").each{|an| an['href'] = an['href'].sub(/^\/en\/help\/v0\.\d\//,'')}

  # p h.serialize( :save_with =>  Nokogiri::XML::Node::SaveOptions::FORMAT )
  h.search("//text()").each{|m| 
    t = m.text
    t.gsub!( /MultiBit/ , 'MultiMona')
    t.gsub!( /Multibit/ , 'Multimona')
    t.gsub!( /multibit/ , 'multimona')
    t.gsub!( /BitCoin/  , 'MonaCoin' )
    t.gsub!( /Bitcoin/  , 'Monacoin' )
    t.gsub!( /bitcoin/  , 'monacoin' )
    t.gsub!( /v0.5.x/   , 'v0.1.x' )
    t.gsub!(/BTC/ , 'MONA')
    t.gsub!(/\r\n/ , "\n" )
    m.content = t
  }

  new_path = NEW_DIR + "/" + File.basename( path )
  open(new_path,'w'){|f|
    f.write h.to_html( :indent => 2 )
  }
}

FileUtils.mkdir_p( NEW_DIR + "/img" )

images = Dir.glob( ORIG_IMG_DIR + "/*.png" )
FileUtils.cp( images , NEW_DIR + "/img" )
