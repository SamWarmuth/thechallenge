class Tracked < CouchRest::ExtendedDocument
  use_database COUCHDB_SERVER
  
  property :name
  property :github_username
  view_by :github_username
  
  property :hidden, :default => false
  view_by :hidden
  
  property :last_updated, :default => Proc.new{Time.now.to_i}
  property :color, :default => "gray"
  
  property :score, :default => 0
  property :last_commit
  property :commits, :default => 0
  property :loc, :default => 0
  property :bugs_identified, :default => 0
  property :bugs_fixed, :default => 0
  property :feature_suggestions, :default => 0
  property :features_implemented, :default => 0
  property :current_streak, :default => 0
  property :longest_streak, :default => 0

  
  property :date, :default => Proc.new{Time.now.to_i}
  
  def update_score
    score = 15
    score += self.bugs_identified * 50
    score += self.feature_suggestions * 25
    score += self.current_streak * 20
    score += self.commits * 5
    score += self.loc
    self.score = score
  end
end