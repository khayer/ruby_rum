module RubyRum
	class ErrorLog

		def initialize(id, datadir)
			dir = datadir + "/error_log_" + id.to_s
			@filehandler = File.new(dir,"w")
			write_error("---- Errorlog for job ID ##{id}: ----e \n")
		end

		def write_error(message)
			@filehandler.write(message)
		end

	
		
	end
end
