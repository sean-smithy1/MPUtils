module Database

require 'mysql2'

  def self.connect
    begin
      Mysql2::Client.new(host: 'localhost', username: 'MPAccounts', password: 'SandyG67', database: 'MP_Accounts')

    rescue Mysql2::Error => e
      puts e.errno
      puts e.error
    end
  end

end
