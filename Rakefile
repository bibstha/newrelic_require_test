require "yaml"
require "active_record"
require "makara"
require "benchmark"

class User < ::ActiveRecord::Base
  self.table_name = :users
end

def connect
  config = YAML.load_file(File.dirname(__FILE__) + '/database.yml')
  ActiveRecord::Base.establish_connection(config)
  require_relative 'schema'
end

def connect_mysql
  config = YAML.load_file(File.dirname(__FILE__) + '/database-mysql.yml')
  ActiveRecord::Base.establish_connection(config)
  require_relative 'schema'
end

connect

class UserInserter
  include Sidekiq::Worker

  def perform(i)
    User.create(name: "Doug #{i}")
    User.find_by(name: "Doug #{i}")
  end
end

