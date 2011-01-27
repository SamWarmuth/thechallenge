class Main
  get "/" do
    @tracked = Tracked.by_hidden(:key => 'false')
    @score_totals = @tracked.inject(1){|sum, user| sum + user.score}
    haml :index
  end
  get "/css/style.css" do
    content_type 'text/css', :charset => 'utf-8'
    sass :style
  end
end
