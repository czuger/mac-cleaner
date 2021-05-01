require 'sqlite3'

KEEP_COOKIES = [
]

def keep_cookie?(row)
  KEEP_COOKIES.each do |kc|
    return true if kc[0] == row[0] && kc[1] == row[1]
  end
  false
end

def delete_cookie?(db, row)
  db.execute( "DELETE FROM cookies WHERE host_key = '#{row[0]}' AND name = '#{row[1]}'" )
end

def clean_cookies(root_dir, path)
  Dir.chdir(root_dir+path)

  db = SQLite3::Database.new 'Cookies'

  db.execute( 'select host_key, name, path from cookies' ) do |row|
    puts "Deleting #{row[0]}, #{row[1]}"
    delete_cookie?(db, row) unless keep_cookie?(row)
  end
end

root_dir = '/' + Dir.pwd.split('/')[1..2].join('/')

puts 'Cleaning Chrome cookies'
clean_cookies(root_dir, '/Library/Application Support/Google/Chrome/Default')

puts 'Cleaning Brave cookies'
clean_cookies(root_dir, '/Library/Application Support/BraveSoftware/Brave-Browser/Default')
