declared_trivial = github.pr_title.include?('#trivial')
has_app_changes = !git.modified_files.grep(/TestApp/).empty?
 
warn 'PR title has to start with the Jira ticket id (e.g. TestApp-123). Use #trivial for commits that do not require a jira ticket id.' if !declared_trivial && !github.pr_title.start_with?('TestApp-')
 
# Warn when there is a big PR
warn('This PR is large, you might need to consider to create smaller PRs') if git.lines_of_code > 800
warn 'PR is classed as Work in Progress' if github.pr_title.include? 'WIP'
 
# Warn when library files has been updated but not tests.
tests_updated = !git.modified_files.grep(/TestAppTests/).empty?
if has_app_changes && !tests_updated
  warn('The source files were changed, but the tests remained unmodified. Consider updating or adding to the tests to match the source changes.')
end