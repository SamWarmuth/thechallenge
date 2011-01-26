class Main
  helpers do
    def update_stats
      sam = Octopi::User.find("SamWarmuth")
      repo = sam.repository("classaxis")
      issues = repo.issues + Octopi::Issue.find_all({:user => sam, :repository => repo, :state => "closed"})
      closed_issues =
        
      Tracked.all.each do |user|
        user.bugs_identified = 0
        user.bugs_fixed = 0
        user.feature_suggestions = 0
        user.features_implemented = 0
        user.save
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

    # Your helpers go here. You can also create another file in app/helpers with the same format.
    # All helpers defined here will be available across all the application.
    #
    # @example A helper method for date formatting.
    #
    #   def format_date(date, format = "%d/%m/%Y")
    #     date.strftime(format)
    #   end
  end
end
