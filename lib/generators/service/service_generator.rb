class ServiceGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def generate_file
    template "service.rb.erb", "app/services/#{service_file_name}.rb"
    template "service_spec.rb.erb", "spec/services/#{service_file_name}_spec.rb"
  end

  private
    def service_class_name
      name.classify
    end

    def service_file_name
      name.underscore
    end
end
