# Gem append content in html body
module InnerHTMLContent
  def add_content(file_name = "index.html", content)
    file_data = File.read(file_name).split('\n ')
    index_body_end = file_data.rindex('</body>')
    new_file_data = file_data.insert(index_body_end, content).join
    File.write(file_name, new_file_data)
  end
end