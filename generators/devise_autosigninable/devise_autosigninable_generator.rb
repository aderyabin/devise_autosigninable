class DeviseAutosigninableGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      m.migration_template 'migration.rb', 'db/migrate', :migration_file_name => "add_autosigninable_to_#{table_name}"      
    end
  end
end
