require './constants'
require 'tmpdir'

URL = ARGV[0]
PATH = URL.split('/')[-1]
$stderr.print "#{Time.now}: #{PATH}\n"

Dir.mktmpdir {|dir|
  system("curl --silent -o #{dir}/#{PATH} #{URL}")
  system("unzip -qq -d #{dir} #{dir}/#{PATH}")
  Dir.glob("#{dir}/*.xml") {|xml_path|
    geojson_path = xml_path.sub(/xml$/, 'geojson')
    system("#{MOJ} -e #{xml_path}")
    system("tippecanoe-json-tool #{geojson_path} | grep -v 任意座標")
  }
}
