require 'fileutils'

namespace :dummy do
  desc "Initialize basic dummy app - adds models and migrations"
  task :init do
    puts "copying migrations and models"

    engine_root_path = File.expand_path('../../..', __FILE__)

    migrate_source = File.join(File.dirname(__FILE__), 'templates', 'migrate')
    migrate_target = File.join(engine_root_path, 'spec', 'dummy', 'db', 'migrate')
    Dir.mkdir(migrate_target) unless File.directory?(migrate_target)
    
    Dir.chdir(migrate_source)
    Dir.glob("*.rb") do |file|
      puts "copy file: #{file} ==> #{migrate_target}"
      FileUtils.copy(file, migrate_target)
    end
    
    models_source = File.join(File.dirname(__FILE__), 'templates', 'models')
    models_target = File.join(engine_root_path, 'spec', 'dummy', 'app', 'models')
    Dir.mkdir(models_target) unless File.directory?(models_target)
    
    Dir.chdir(models_source)
    Dir.glob("*.rb") do |file|
      puts "copy file: #{file} ==> #{models_target}"
      FileUtils.copy(file, models_target)
    end
    
    # copy user migration (devise)
    user_migrate = File.join(engine_root_path, "lib", "generators", "engine_room", "templates", "001_devise_create_users.rb")
    puts "copy file: #{user_migrate} ==> #{models_target}"
    FileUtils.copy(user_migrate, migrate_target)

    puts "fin."
  end
end