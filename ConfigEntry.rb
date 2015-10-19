
class ConfigEntry
	attr_accessor :type, :software, :version_command, :version, :prompt_message

	COMMAND = 1 # You want execute a command like javac -version to check for existence of software
	HTTP    = 2 # You want find a service is running using HTTP 
	PORT = 3 # You want to check if the service is running on sepecified port

	def initialize(type = COMMAND,software,version_command,version,prompt_message)
		@type            = type
		@software        = software
		@version_command = version_command
		@version         = version
		@prompt_message  = prompt_message
	end

	def to_s
		"[#{@software},#{@version}]"
	end


end