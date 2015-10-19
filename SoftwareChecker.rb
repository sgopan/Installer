require_relative 'ConfigEntry'
require 'open3'
require 'socket'  
require 'net/http'

class SoftwareChecker

	def self.is_software_installed? config_entry	
		case config_entry.type
		when ConfigEntry::COMMAND 
			puts "Conifg Entry is COMMAND"
			return command_checker config_entry
		when ConfigEntry::HTTP
			puts "Conifg Entry is HTTP"
			http_checker config_entry
		when ConfigEntry::PORT
			puts "Conifg Entry is PORT"
			port_checker config_entry
		else puts "UNKOWN type"
		end	
	end

	def self.command_checker config_entry
		out,error,status = Open3.capture3(config_entry.version_command)
		if status.success?
			version_match = error.scan(config_entry.version)
			if version_match.size > 0 
			    puts "#{config_entry.software} #{config_entry.version}  found"
			    return true
			else 
				puts config_entry.prompt_message
				return false
			end

		else 
			puts config_entry.prompt_message
			return false
		end

	end

	def self.http_checker config_entry
		begin
			url = "http://localhost:#{config_entry.version_command}"
			puts "Checking #{config_entry.software} at url -  #{url}"
			result = Net::HTTP.get(URI.parse(url))	
			if result.scan(config_entry.version).size > 0
				puts "#{config_entry.software} #{config_entry.version}  found"
				return true
			else
				puts config_entry.prompt_message
				return false							
			end	
		rescue Exception =>e
			puts e.message
			puts "Error while trying to find elastic search status. #{config_entry.prompt_message}"
			return false
		end			
	end

	def self.port_checker config_entry
		begin
			TCPSocket.open(Socket.gethostname, config_entry.version_command)	
			return true	
		rescue 
			puts "#{config_entry.prompt_message} #{config_entry.version}"
			return false
		end
	end

	#make theses private
	#private :command_checker, :path_checker, :service_checker
end