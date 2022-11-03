# frozen_string_literal: true

# Gem append content in html body
module InnerHTMLContent
  class << self
    def add_content(content, bypass_html: true, file_name: 'index.html')
      serialize_content = content.gsub(%r{<\w+>|</\w+>}, '')
      content = bypass_html && serialize_content ? content.gsub(%r{<\w+>|</\w+>}, '') : content

      template_html(file_name, content)
    end

    private

    def template_html(file_name, content)
      template = '<!DOCTYPE html>
      <html lang="en">
        <head>
          <meta charset="UTF-8">
          <meta http-equiv="X-UA-Compatible" content="IE=edge">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <title>Title page</title>
        </head>
        <body>
        inner_content
        </body>
      </html>'
      template = template.gsub('inner_content', content)

      File.open(file_name, 'w') do |file|
        file.write(template)
      end
    end
  end
end
