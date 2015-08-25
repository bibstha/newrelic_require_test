if ARGV[0] == "bug"
  require "newrelic_rpm"
  require "active_record"
else
  require "active_record"
  require "newrelic_rpm"
end

require "yaml"
require "benchmark"
require "sidekiq"

class User < ::ActiveRecord::Base
  self.table_name = :users
end

def connect_mysql
  config = YAML.load_file(File.dirname(__FILE__) + '/database-mysql.yml')
  ActiveRecord::Base.establish_connection(config)
  require_relative 'schema'
end

connect_mysql

class UserInserter
  include Sidekiq::Worker

  def perform(i)
    User.create(name: "Doug #{i}")
    User.find_by(name: "Doug #{i}")
  end
end

Sidekiq::Queue.all.map(&:clear)
10.times { |x| UserInserter.perform_async(x) }
