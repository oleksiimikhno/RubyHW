# Gem append content in html body
module InnerHTMLContent
  def add_content(file_name = "index.html", content)
    file = File.read(file_name)
    split_file = file.split(' ').to_a
    index_body_end = split_file.rindex('</body>')
    split_file.insert(index_body_end, content).join('')
  end
end