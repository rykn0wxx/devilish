module ApplicationHelper

	def li_link_to(link_label, options={})
		valid_options = [:controller, :action].freeze
	  active_when = options.slice(*valid_options) { Hash.new }
		is_active = active_when.all? do |key, value|
			case value
			when Regexp
				params[key].to_s =~ value
			else
				params[key].to_s == value
			end
		end
		content_tag(:li, :class => is_active ? 'parent-list-item active' : 'parent-list-item') do
			link_to(link_label, url_for(controller: active_when[:controller], action: active_when[:action]), :class => is_active ? 'md-button active' : 'md-button')
		end
	end

end
