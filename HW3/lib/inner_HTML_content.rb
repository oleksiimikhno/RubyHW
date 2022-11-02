# Gem append content in html body
module InnerHTMLContent
  def self.add_content(content, file_name = 'index.html')
    file_data = File.read(file_name).partition('<body>')
    new_file_data = file_data.insert(2, "\n#{content}").join
    File.write(file_name, new_file_data)
  end
end
