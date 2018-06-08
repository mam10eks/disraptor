# name: disraptor
# about: I don’t know how to describe it, yet.
# version: 0.1
# authors: Philipp Rudloff
# url: http://disraptor.org

enabled_site_setting :disraptor_enabled

register_asset 'stylesheets/disraptor.scss'

# Adds a link the Disraptor plugin on the `/admin/plugins` page with the route `disraptor`.
add_admin_route 'disraptor.title', 'disraptor'

after_initialize do
  module ::Disraptor
    PLUGIN_NAME ||= 'disraptor'.freeze
  end

  load File.expand_path('../lib/route_store.rb', __FILE__)
  load File.expand_path('../app/controllers/disraptor_config_controller.rb', __FILE__)
  load File.expand_path('../app/models/route.rb', __FILE__)

  Discourse::Application.routes.append do
    # Serve the default plugins content when the user directly opens the Disraptor plugin.
    get '/admin/plugins/disraptor' => 'admin/plugins#index', constraints: AdminConstraint.new

    # Note sure if this is the right place for these routes.
    get '/disraptor_routes' => 'disraptor_config#index', constraints: AdminConstraint.new
    put '/disraptor_routes/:route_id' => 'disraptor_config#update', constraints: AdminConstraint.new
    delete '/disraptor_routes/:route_id' => 'disraptor_config#destroy', constraints: AdminConstraint.new
  end
end
