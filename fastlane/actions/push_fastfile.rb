module Fastlane
  module Actions
    module SharedValues
      PUSH_FASTFILE_CUSTOM_VALUE = :PUSH_FASTFILE_CUSTOM_VALUE
    end

    class PushFastfileAction < Action
      def self.run(params)
      
      success_message = "Successfully added Fastfile 💾."
      command = "git add fastlane/Fastfile"
      result = Actions.sh(command, log: FastlaneCore::Globals.verbose?).chomp
      UI.success(success_message)
      
      success_message = "Successfully commited Fastfile 💾."
      commit_message = "Update Fastfile"
      command = "git commit -m \"#{commit_message}\""
      result = Actions.sh(command, log: FastlaneCore::Globals.verbose?)
      UI.success(success_message)

      current_branch = Actions.git_branch
      success_message = "Successfully pushed Fastfile 💾."
      command = "git push origin \"#{current_branch}\""
      result = Actions.sh(command, log: FastlaneCore::Globals.verbose?)
      UI.success(success_message)

      return result


        # fastlane will take care of reading in the parameter and fetching the environment variable:
        UI.message "Parameter API Token: #{params[:api_token]}"

        # sh "shellcommand ./path"

        # Actions.lane_context[SharedValues::PUSH_FASTFILE_CUSTOM_VALUE] = "my_val"
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "A short description with <= 80 characters of what this action does"
      end

      def self.details
        # Optional:
        # this is your chance to provide a more detailed description of this action
        "You can use this action to do cool things..."
      end

      def self.available_options
        # Define all options your action supports. 
        
        # Below a few examples
        [
          FastlaneCore::ConfigItem.new(key: :api_token,
                                       env_name: "FL_PUSH_FASTFILE_API_TOKEN", # The name of the environment variable
                                       description: "API Token for PushFastfileAction", # a short description of this parameter
                                       verify_block: proc do |value|
                                          UI.user_error!("No API token for PushFastfileAction given, pass using `api_token: 'token'`") unless (value and not value.empty?)
                                          # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :development,
                                       env_name: "FL_PUSH_FASTFILE_DEVELOPMENT",
                                       description: "Create a development certificate instead of a distribution one",
                                       is_string: false, # true: verifies the input is a string, false: every kind of value
                                       default_value: false) # the default value if the user didn't provide one
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
          ['PUSH_FASTFILE_CUSTOM_VALUE', 'A description of what this value contains']
        ]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.authors
        # So no one will ever forget your contribution to fastlane :) You are awesome btw!
        ["Your GitHub/Twitter Name"]
      end

      def self.is_supported?(platform)
        # you can do things like
        # 
        #  true
        # 
        #  platform == :ios
        # 
        #  [:ios, :mac].include?(platform)
        # 

        platform == :ios
      end
    end
  end
end
