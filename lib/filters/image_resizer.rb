class ImageResizer < Nanoc::Filter
	identifier :image_resizer
	type       :binary

	def run(filename, params={})
		system(
			'convert',
			'-resize',
			params[:width].to_s,
			filename,
			output_filename
		)
	end
end
