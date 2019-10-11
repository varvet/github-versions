# frozen_string_literal: true

require 'octokit'
require 'bundler'

personal_token = ARGV[0]

if personal_token.nil?
  puts 'Please provide a Github personal access token.'
  return
end

client = Octokit::Client.new(access_token: personal_token)
client.auto_paginate = true

repositories = client.org_repositories('varvet')

versions = repositories.map do |repository|
  repo_name = repository.full_name

  begin
    encoded_lockfile = client.contents(repo_name, path: 'Gemfile.lock').content

    lockfile = Base64.decode64(encoded_lockfile)

    parsed_lockfile = Bundler::LockfileParser.new(lockfile)

    rails_specification = parsed_lockfile.specs.select { |spec| spec.name == 'rails' }.first

    version = if rails_specification
                rails_specification.version.to_s
              else
                version = 'n/a'
              end
  rescue Octokit::NotFound
    version = 'n/a'
  end

  "#{repository.name} - #{version}"
end

puts versions
