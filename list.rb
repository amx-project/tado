require './constants'
require 'json'

def api(url)
  JSON.parse(`curl --silent #{url}`)
end

REPOS.each {|repo|
  sha = api("https://api.github.com/repos/#{ORG}/#{repo}/contents")
  .find {|o| o['name'] == 'xml'} ["sha"]
  api("https://api.github.com/repos/#{ORG}/#{repo}/git/trees/#{sha}")["tree"]
  .each {|o| 
    path = o["path"]
    return unless /zip$/.match path
    print "https://raw.githubusercontent.com/#{ORG}/#{repo}/main/xml/#{path}\n"
  }
}