module Evilspace
  class Railtie < Rails::Railtie
    initializer "evilspace.insert_middleware" do |app|
      app.config.middleware.use 'Evilspace::Middleware'
    end
  end
end
