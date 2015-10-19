require_relative 'Configs'
require_relative 'FileUtil'
require_relative 'SoftwareChecker'

class InstallationManager

	def initialize
		@configs = Configs.new	
		@fileUtil = FileUtil.new	
		@configs.load

	end

	def startInstall
		if(@fileUtil.checkPermission)
		  @configs.print_config_for_software
		  check_for_prerequisites
		else
			puts "The user does not have write permissions in directory -"+Dir.pwd
		end
	end

	

	def check_for_prerequisites
		puts "Checking for prerequisites"
		config_entries = @configs.config_array
		config_entries.each do |config_entry|
			if !SoftwareChecker.is_software_installed? config_entry 
				puts "One of the prerequisites checks failed. Please install and rerun the installer"
				break			
			end
		end
	end



	#make these private
	private :check_for_prerequisites

end

installManager = InstallationManager.new
installManager.startInstall


