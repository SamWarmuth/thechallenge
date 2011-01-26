class Main
  get "/" do
    @tracked = Tracked.all
    @score_totals = @tracked.inject(0){|sum, user| sum + user.score}
    haml :index
  end
  get "/css/style.css" do
    content_type 'text/css', :charset => 'utf-8'
    sass :style
  end
end
