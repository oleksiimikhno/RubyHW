# frozen_string_literal: true

require 'erb'
require 'inner_html_content'

template = File.read('view/content.erb')

@name = 'Jogn'

html_content = ERB.new(template).result

InnerHTMLContent.add_content('', html_content, bypass_html: false)
