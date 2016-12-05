module ProjectsHelper
	def set_value
		if @project.owner_tags_on(@project.poster,:tags).count == 0
			""
		else
			array= Array.new
			@project.owner_tags_on(@project.poster,:tags).each do |tag|
				temp = "#{tag}, "
				array << temp
			end

			array
		end
	end
end
