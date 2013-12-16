require 'json'
require 'httparty'
require 'github_api'

class VersionController < ApplicationController
  def dashboard
    unfiltered_pulls = github.pull_requests.all(:user => 'cbdr', :repo => 'CB-Mobile', :state => 'closed', :base => 'production')
    @pulls = []
    unfiltered_pulls.each do |pull|
      @pulls << pull if pull.merged_at.nil? == false
    end
  end

  def index
    @thispull = github.pull_requests.get(:user => 'cbdr', :repo => 'CB-Mobile', :number => params['id'])
    @commits = github.pull_requests.commits(:user => 'cbdr', :repo => 'CB-Mobile', :number => params['id'])
    find_jobsearch_changes find_gemfile_changes
  end

  private


  def find_gemfile_changes
    #@files = Rails.cache.fetch("pulls/#{params['id']}/files", :expires_in => 12.hours) do
    #  github.pull_requests.files(:user => 'cbdr', :repo => 'CB-Mobile', :number => params['id'])
    #end


    @files = github.pull_requests.files(:user => 'cbdr', :repo => 'CB-Mobile', :number => params['id'])

    patches_to_parse = []
    refs = []
    @files.each do |file|
      patches_to_parse << file.patch if file.filename = "Gemfile"
    end

    patches_to_parse.each do |patch|
      refs.concat patch.scan(/ref: ?'(\w+)'/) if patch.nil? == false
    end
    refs
  end

  def find_jobsearch_changes(refs)
    dates = []
    @jobsearch_changes = []

    refs.each do |sha|
      begin
        commit = github.repos.commits.get(:user => 'cbdr', :repo => 'JobSearch', :sha => sha[0].to_s)
        dates << DateTime.parse(commit["commit"]["author"]["date"]) if commit["commit"].nil? == false
      rescue
        #didn't find this commit
      end
    end

    if dates.count >= 2
      max_date = dates.max
      min_date = dates.min
      pulls = github.pull_requests.all(:user => 'cbdr', :repo => 'JobSearch', :state => 'closed',:base => 'master')

       pulls.each do |pull|
        closed_date = DateTime.parse(pull.closed_at)
        @jobsearch_changes << pull if closed_date <= max_date && closed_date >= min_date
      end

    end
  end
end
