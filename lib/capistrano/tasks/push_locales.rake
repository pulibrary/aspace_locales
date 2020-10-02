
namespace :locales do
  desc "Publish the locales to an ArchivesSpace installation"
  task :push do
    on roles(:app) do |host|
      info "Host #{host} (#{host.roles.to_a.join(', ')}):\t#{capture(:uptime)}"
      info "Uploading #{File.dirname(__FILE__)}/common/locales}..."
      upload!("#{File.dirname(__FILE__)}/common/locales", "#{current_path}/common/locales")
      info "Host #{host} (#{host.roles.to_a.join(', ')}):\t#{capture(:uptime)}"
      info "Uploaded #{File.dirname(__FILE__)}/common/locales}"
    end
  end
end
