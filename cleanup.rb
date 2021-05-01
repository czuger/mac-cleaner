require 'fileutils'

directories = [
  '/Users/ced/Library/Application Support/Google/Chrome/Default/Service Worker/CacheStorage',
  '/Users/ced/Library/Application Support/Google/Chrome/Profile 1/Service Worker/CacheStorage',
  '/Users/ced/Library/Application Support/Slack/Service Worker/CacheStorage',
  '/Users/ced/Library/Caches'
]

directories.each do |dir|
  Dir["#{dir}/*"].each do |path|
    puts "Deleting #{path}/*"
    begin
      FileUtils.rm_r Dir.glob("#{path}/*")
    rescue Exception => e
      p e
    end
  end
end
