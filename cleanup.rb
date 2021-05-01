require 'fileutils'

directories = [
  '~/Library/Application Support/Google/Chrome/Default/Service Worker/CacheStorage',
  '~/Library/Application Support/Google/Chrome/Profile 1/Service Worker/CacheStorage',
  '~/Library/Application Support/Slack/Service Worker/CacheStorage',
  '~/Library/Caches'
]

puts 'Cleaning directories'
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
