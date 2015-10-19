require 'yaml'
require_relative 'ConfigEntry'

class Configs
	attr_accessor :config_array

	def initialize 
		@config_array = []
	end

	def load config_file = "configurations.yml"
		@config_file  = config_file
		@config_array = @config_array ? YAML::load( (File.read( @config_file )) ) : []
	end

	def addConfigEntry config
		@config_array << config
	end

	def addConfigEntries configs
		@config_array += configs
	end

	def self.create_sample_config_file
		config_entries = [
			ConfigEntry.new("java",  "javac -version", "1.8", "JDK 1.8 is not installed. Please install JDK 1.8" ),
      		ConfigEntry.new("scala", "scala -version", "2.11", "Scala 2.11 is not installed. Please install Scala 2.11" ),
		]
		File.open "configurations.yml","w" do |f|
			f.write YAML::dump config_entries
		end
	end

	def generate_config_file 
		File.open "configurations.yml","w" do |f|
			f.write YAML::dump @config_array
		end
	end

	def print_config_for_software
		puts "Configuration used for installation"
		puts "{"
		@config_array.each do |entry|
			puts "\t #{entry}" 
			puts 
		end
		puts "}"
	end

end

