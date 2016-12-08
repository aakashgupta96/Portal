module ProjectsHelper
	def set_value project
		if project.tag_list.count == 0
			""
		else
			array= Array.new
			project.tag_list.each do |tag|
				temp = "#{tag}, "
				array << temp
			end
			array
		end
	end
end
