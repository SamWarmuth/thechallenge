class Torch < CouchRest::ExtendedDocument
  use_database COUCHDB_SERVER
  
  property :name
  property :github_username
  
  property :last_updated, :default => Proc.new{Time.now.to_i}
  property :color, :default => "gray"
  
  property :score, :default => 0
  property :last_push
  property :LOC, :default => 0
  property :bugs_identified, :default => 0
  property :bugs_fixed, :default => 0
  property :feature_suggestions, :default => 0
  property :features_implemented, :default => 0
  property :longest_streak, :default => 0

  
  property :date, :default => Proc.new{Time.now.to_i}
end