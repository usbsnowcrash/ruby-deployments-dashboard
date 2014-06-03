class ProjectChangesetsProcedure < BaseProcedure
  ViewData = Struct.new(:this_pull, :commits, :jobsearch_changes)

  def view_data
    thispull = github.pull_requests.get(user: 'cbdr', repo: 'CB-Mobile', number: params['id'])
    commits = github.pull_requests.commits(user: 'cbdr', repo: 'CB-Mobile', number: params['id'])
    jobsearch_changes = find_jobsearch_changes find_gemfile_changes

    ViewData.new(thispull, commits, jobsearch_changes)
  end

  private

  def github
    Github.new do |config|
      config.oauth_token = ENV['GITHUB_TOKEN']
      config.org = 'cbdr'
      config.auto_pagination = true
    end
  end

  def find_gemfile_changes
    files = github.pull_requests.files(user: 'cbdr', repo: 'CB-Mobile', number: params['id'])

    patches_to_parse = []
    refs = []
    files.each do |file|
      patches_to_parse << file.patch if file.filename = 'Gemfile'
    end

    patches_to_parse.each do |patch|
      refs.concat patch.scan(/ref: ?'(\w+)'/) if patch.nil? == false
    end
    refs
  end

  def find_jobsearch_changes(refs)
    dates = []
    jobsearch_changes = []

    refs.each do |sha|
      begin
        commit = github.repos.commits.get(user: 'cbdr', repo: 'JobSearch', sha: sha[0].to_s)
        dates << DateTime.parse(commit['commit']['author']['date']) if commit['commit'].nil? == false
      rescue
        # didn't find this commit
      end
    end

    if dates.count >= 2
      max_date = dates.max
      min_date = dates.min
      pulls = github.pull_requests.all(user: 'cbdr', repo: 'JobSearch', state: 'closed', base: 'master')

      pulls.each do |pull|
        closed_date = DateTime.parse(pull.closed_at)
        jobsearch_changes << pull if closed_date <= max_date && closed_date >= min_date
      end

    end

    jobsearch_changes
  end
end
