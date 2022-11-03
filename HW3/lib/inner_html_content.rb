require 'erb'

# Gem append content in html body
module InnerHTMLContent
  def self.add_content(content, bypass_html: true, file_name: 'index.html')
    content = bypass_html ? content.gsub!(%r{<\w+>|</\w+>}, '') : content

    puts template_html(file_name)
    puts File.read(file_name)

    file_data = File.read(file_name).partition('<body>')
    new_file_data = file_data.insert(2, "\n#{content}").join
    File.write(file_name, new_file_data)
  end

  private

  def template_html(file_name = 'index.html')
    file = File.new(file_name, 'w')


    File.open(file_name, "w") do |file|     
      file.write(default_template)   
    end
    default_template = '
    <!DOCTYPE html>
    <html lang="en">
      <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Title page</title>
      </head>
      <body>
        {html_content}
      </body>
    </html>'
    file.write(file_name, default_template)
    rr = File.read(file_name)
  end
end
