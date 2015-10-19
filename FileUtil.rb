
class FileUtil

	def initialize dirPath = Dir.pwd
		if File::directory?(dirPath)
			@dirPath = dirPath
		else raise "#{dirPath} is not a directory. Please provide a directory path."
		end
	end


	def checkPermission
		File.writable?(@dirPath)		
	end


end

fileUtil = FileUtil.new(Dir.pwd)
fileUtil.checkPermission
#fileUtil = FileUtil.new("Bitch")

