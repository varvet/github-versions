# Github versions

A script for viewing the versions of key dependencies in Varvet projects.

Currently shows the Rails version from a Gemfile.lock

## Setup

```
bundle install
```

Then generate a GitHub
[Personal Access Token](https://help.github.com/en/articles/creating-a-personal-access-token-for-the-command-line),
giving it "repo" access

## Usage 

```
ruby github_versions.rb <personal access token>
```
