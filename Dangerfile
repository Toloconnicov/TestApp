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

# Check if all files and folders in the Xcode project are added to git
require 'xcodeproj'
 
def recurse_xcode_groups(groups)
  groups.each do |local_group|
    recurse_xcode_groups(local_group.groups) if local_group.groups.count > 0
 
    fail("Xcode group reference '#{local_group.hierarchy_path}' is not in git. Please remove it, or add the folder to git.") unless File.directory?(local_group.real_path)
 
    local_group.files.each do |file|
      filename = file.path
      fail("Xcode file reference '#{file.hierarchy_path}' is not in git. Please remove it, or add the folder to git.") unless File.exist?(file.real_path)
    end
  end
end
 
project_path = 'TestApp.xcodeproj'
project = Xcodeproj::Project.open(project_path)
 
project.groups.each do |group|
  recurse_xcode_groups(group.groups)
end
 
# Check ObjC style
clang_format_output = `./scripts/clang-format.sh lint`
if $?.exitstatus != 0
    clang_format_output.split("\n").each do |line|
        fail(line)
    end
end
 
# Check Swift style
swiftlint_output = `swiftlint &> .swiftlint_output; cat .swiftlint_output | grep 'warning\\|error'`
unless swiftlint_output.to_s.empty?
  output_message = `cat .swiftlint_output | grep 'Done linting!'`.delete("\n").gsub('Done linting', 'Done linting swift sources')
  output_message += "Some swiftlint warnings can be fixed by running 'swiftlint autocorrect'"
  fail(output_message)
  swiftlint_output.split("\n").each do |file|
    fail(file.split('/').last)
  end
end