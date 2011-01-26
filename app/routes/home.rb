class Main
  get "/" do
    haml :index
  end
  get "/css/style.css" do
    content_type 'text/css', :charset => 'utf-8'
    sass :style
  end
end
