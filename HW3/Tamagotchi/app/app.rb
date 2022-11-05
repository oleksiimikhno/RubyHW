require 'erb'
require 'inner_html_content'


template = File.read('view/content.erb')
html_content = ERB.new(template).result
cc = InnerHTMLContent.add_content('qwe', html_content, bypass_html: false)
p cc
class App
  def call(env)
    [200, {}, [cc]]
  end
end