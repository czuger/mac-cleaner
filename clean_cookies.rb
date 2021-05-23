require 'sqlite3'
require 'json'

def keep_cookie?(row)
  $addr_keep.each do |addr|
    if row[0].include?(addr)
      return true
    end
  end
  return false
end

def delete_cookie(db, row)
  db.execute( "DELETE FROM cookies WHERE host_key = '#{row[0]}' AND name = '#{row[1]}'" )
end

def clean_cookies(root_dir, path)
  Dir.chdir(root_dir+path)

  db = SQLite3::Database.new 'Cookies'

  db.execute( 'select host_key, name, path from cookies' ) do |row|
    unless keep_cookie? row
      puts "Deleting #{row[0]}, #{row[1]}"
      delete_cookie(db, row)
    else
      puts "Keeping #{row[0]}, #{row[1]}"
    end
  end
end

s = File.read('address_keep.json')
$addr_keep = JSON.parse(s)

root_dir = '/' + Dir.pwd.split('/')[1..2].join('/')

puts 'Cleaning Chrome cookies'
clean_cookies(root_dir, '/Library/Application Support/Google/Chrome/Default')

puts 'Cleaning Brave cookies'
clean_cookies(root_dir, '/Library/Application Support/BraveSoftware/Brave-Browser/Default')
