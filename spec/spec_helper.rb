# -- coding: utf-8

require "rubygems"
require "bundler"
Bundler.require :default, :test

db_config = YAML.load(IO.read "database.yml")
ActiveRecord::Base.establish_connection db_config

Dir["./spec/support/**/*.rb"].each{|file| require file }

RSpec.configure do |config|
  config.include(Execution)

  config.around(:each) do |example|
    ActiveRecord::Base.transaction do
      example.run
      raise ActiveRecord::Rollback
    end
  end

end
