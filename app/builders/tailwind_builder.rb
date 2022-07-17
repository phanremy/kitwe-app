# frozen_string_literal: true

class TailwindBuilder < ActionView::Helpers::FormBuilder
  # include ActionView::Helpers::TagHelper
  # include ActionView::Context

  def text_field(attribute, options = {})
    super(attribute, options.merge(class: 'appearance-none block w-full text-gray-700 ' \
                                          'border border-gray-400 rounded px-3 leading-tight bg-white'))
  end

  def text_area(attribute, options = {})
    super(attribute, options.merge(class: 'appearance-none block w-full text-gray-700 ' \
                                          'border border-gray-400 rounded px-3 leading-tight bg-white'))
  end

  def date_field(attribute, options = {})
    super(attribute, options.merge(class: 'appearance-none block w-full text-gray-700 ' \
                                          'border border-gray-400 rounded px-3 leading-tight bg-white'))
  end

  def select(object_name, method_name, template_object, options = {})
    super(object_name, method_name, template_object,
          options.merge(class: 'border border-gray-400 rounded px-3 leading-tight bg-white',
                        style: 'min-width: 9em'))
  end

  def div_radio_button(method, tag_value, options = {})
    @template.content_tag(:div, @template.radio_button(
                                  @object_name, method, tag_value, objectify_options(options)
                                ))
  end

  def submit(attribute, options = {})
    super(attribute, options.merge(class: 'bg-blue-500 hover:bg-blue-700 text-white ' \
                                          'font-bold py-2 px-4 rounded cursor-pointer'))
  end
end
