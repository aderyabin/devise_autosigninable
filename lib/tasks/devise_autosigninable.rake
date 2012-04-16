namespace :devise do
  namespace :autosigninable do
    desc 'Generate missed autosignin tokens, by default for User model'
    task :ensure, :model, :needs => [:environment] do |t, args|
      args.with_defaults(:model => "User")
      args.model.camelize.constantize.ensure_all_autosignin_tokens
    end

    desc 'Reset all autosignin tokens, by default for User model'
    task :reset, :model, :needs => [:environment] do |t, args|
      args.with_defaults(:model => "User")
      args.model.camelize.constantize.reset_all_autosignin_tokens
    end
  end
end
