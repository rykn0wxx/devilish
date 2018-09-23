# frozen_string_literal: true
SimpleForm.setup do |config|
	config.wrappers :default, class: 'md-field-group md-input-container', hint_class: :field_with_hint, error_class: 'md-input-invalid', valid_class: 'md-input-has-value' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
		b.optional :icon
		b.use :input
		b.use :label
		b.use :ripple_line
		b.use :hint,  wrap_with: { tag: :span, class: :hint }
		b.use :error, wrap_with: { tag: :span, class: :error }
  end

  config.default_wrapper = :default
  config.boolean_style = :nested
  config.button_class = 'md-button'
  config.error_notification_tag = :div
  config.error_notification_class = 'error_notification'
  config.label_text = lambda { |label, required, explicit_label| "#{label}" }
  config.label_class = 'md-field-label'
	config.default_form_class = 'md-form'
  config.required_by_default = true
  config.browser_validations = true
  config.translate_labels = true
  config.input_class = 'md-input md-field-input'
  config.boolean_label_class = 'checkbox'
end
