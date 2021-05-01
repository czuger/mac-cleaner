require 'sqlite3'

def show_cookies(root_dir, path)
  Dir.chdir(root_dir+path)

  db = SQLite3::Database.new 'Cookies'

  db.execute( 'select host_key, name, path from cookies' ) do |row|
    p row
  end
end

root_dir = '/' + Dir.pwd.split('/')[1..2].join('/')

puts 'Showing Chrome cookies'
show_cookies(root_dir, '/Library/Application Support/Google/Chrome/Default')

puts 'Showing Brave cookies'
show_cookies(root_dir, '/Library/Application Support/BraveSoftware/Brave-Browser/Default')
