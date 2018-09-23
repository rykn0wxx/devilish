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

	def class_from_opt(resource_name)
	  resource_name.to_s.classify.constantize
	end

	def show_resource_name(resource_name)
	  class_from_opt(resource_name).
			model_name.
			human(
				count: 2.1,
				default: resource_name.to_s.pluralize.titleize
			)
	end

	def toolbar_title(options = {})
		tb_title = options[:main]
		tb_sub = options[:sub] unless options[:sub].nil?
	  content_for(:toolbar_title) do
	  	toolbar_content(tb_title, tb_sub)
	  end
	end

	private

	def toolbar_content(title, sub)
	  main = content_tag(:span, title.titleize, :class => 'md-breadcrumb-page')
		if sub.nil?
			main
		else
			seperator = content_tag(:span, :class => 'menu-seperator') do
				content_tag(:i, 'chevron_right', :class => 'material-icons md-icon')
			end
			sub_menu = content_tag(:span, sub.titleize, :class => 'md-breadcrumb-page sub-page')
			main + seperator + sub_menu
		end
	end

end
