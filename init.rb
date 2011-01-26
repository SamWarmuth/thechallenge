ROOT_DIR = File.expand_path(File.dirname(__FILE__)) unless defined? ROOT_DIR

require "rubygems"

begin
  require "vendor/dependencies/lib/dependencies"
rescue LoadError
  require "dependencies"
end

require "monk/glue"
require "couchrest"
require "haml"
require "sass"
require "json"
require "octopi"
require "rufus/scheduler"


class Main < Monk::Glue
  set :app_file, __FILE__
  use Rack::Session::Cookie
end

# Connect to couchdb.
couchdb_url = monk_settings(:couchdb)[:url]
COUCHDB_SERVER = CouchRest.database!(couchdb_url)



# Load all application files.
Dir[root_path("app/**/*.rb")].each do |file|
  require file
end


if defined?(Scheduler).nil?
  Scheduler = Rufus::Scheduler.start_new
  Scheduler.every "2m", :first_in => '30s' do
    sam = Octopi::User.find("SamWarmuth")
    repo = sam.repository("classaxis")
    issues = repo.issues + Octopi::Issue.find_all({:user => sam, :repository => repo, :state => "closed"})
    commits = repo.commits
      
    Tracked.all.each do |user|
      user.bugs_identified = 0
      user.bugs_fixed = 0
      user.feature_suggestions = 0
      user.features_implemented = 0
      user.commits = 0
      
      user.save
    end
    
    commits.each do |commit|
      username = commit.map{|c| c.author['login']}
      user = Tracked.by_github_username(:key => issue.user).first
      unless user.nil?
        user.commits += 1
        user.save
      end
    end
    issues.each do |issue|
      creator = Tracked.by_github_username(:key => issue.user).first
      unless creator.nil?
        if issue.labels.include?("bug")
          creator.bugs_identified += 1
          creator.update_score
          creator.save
        elsif issue.labels.include?("feature")
          creator.features_identified += 1
          creator.update_score
          creator.save
        end
      end
      
      if issue.state == "closed"
        
      end
    end
    Tracked.all.each{|t| t.update_score; t.save}
    
  end
end

Main.run! if Main.run?
