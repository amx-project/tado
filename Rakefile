task :default do
  sh <<-EOS
ruby list.rb | parallel --line-buffer ruby sequence.rb > a.geojsons
  EOS
end
