module ProjectsHelper
	def set_value
		#byebug
		if @project.owner_tags_on(@project.poster,:skills).count == 0
			""
		else
			array= Array.new
			@project.owner_tags_on(@project.poster,:skills).each do |tag|
				temp = "#{tag}, "
				array << temp
			end

			array
		end
	end
end
