#!/usr/bin/env ruby

require 'yaml'

require './lib/github_fetcher.rb'
require './lib/message_builder.rb'
require './lib/slack_poster.rb'

# Entry point for the Seal!
class Seal

  attr_reader :mode

  def initialize(team, mode=nil)
    @team = team
    @mode = mode
  end

  def bark
    teams.each { |team| bark_at(team) }
  end

  private

  attr_accessor :mood

  def teams
    if @team.nil? && org_config
      org_config.keys.reject { |x| x.to_s.start_with? '_' }
    else
      [@team]
    end
  end

  def bark_at(team)
    config = team_params(team)
    message_builder = MessageBuilder.new(team: team, content: content_for_team(config), mode: @mode)
    message = message_builder.build
    channel = ENV["SLACK_CHANNEL"] ? ENV["SLACK_CHANNEL"] : team_config(team)['channel']
    slack = SlackPoster.new(ENV['SLACK_WEBHOOK'], channel, message_builder.poster_mood)
    slack.send_request(message)
  end

  def org_config
    @org_config ||= YAML.load_file(configuration_filename) if File.exist?(configuration_filename)
  end

  def configuration_filename
    @configuration_filename ||= "./config/#{ENV['SEAL_ORGANISATION']}.yml"
  end

  def team_params(team)
    config = team_config(team)
    return config if config
    {
      'members' => ENV['GITHUB_MEMBERS'] ? ENV['GITHUB_MEMBERS'].split(',') : [],
      'use_labels' => ENV['GITHUB_USE_LABELS'] ? ENV['GITHUB_USE_LABELS'].split(',') : nil,
      'exclude_labels' => ENV['GITHUB_EXCLUDE_LABELS'] ? ENV['GITHUB_EXCLUDE_LABELS'].split(',') : nil,
      'exclude_titles' => ENV['GITHUB_EXCLUDE_TITLES'] ? ENV['GITHUB_EXCLUDE_TITLES'].split(',') : nil,
      'exclude_repos' => ENV['GITHUB_EXCLUDE_REPOS'] ? ENV['GITHUB_EXCLUDE_REPOS'].split(',') : nil,
      'include_repos' => ENV['GITHUB_INCLUDE_REPOS'] ? ENV['GITHUB_INCLUDE_REPOS'].split(',') : nil,
      'quotes' => ENV['SEAL_QUOTES'] ? ENV['SEAL_QUOTES'].split(',') : nil
    }
  end

  def content_for_team(team_params)
    if @mode.nil?
      fetch_from_github(team_params['members'], team_params['use_labels'], team_params['exclude_labels'], team_params['exclude_titles'], team_params['exclude_repos'], team_params['include_repos'])
    else
      team_params['quotes']
    end
  end

  def fetch_from_github(members, use_labels, exclude_labels, exclude_titles, exclude_repos, include_repos)
    git = GithubFetcher.new(members,
                            use_labels,
                            exclude_labels,
                            exclude_titles,
                            exclude_repos,
                            include_repos
                           )
    git.list_pull_requests
  end

  def team_config(team)
    org_config[team] if org_config
  end
end
