module JavascriptConcatenator

	# Content directory where JavaScript is stored
	@@js_dir   = '/js/'

	def concatenate_js()
		scripts = @items.select { |item| item.identifier.start_with? @@js_dir and item.identifier != @@js_dir+'scripts/' }
		concatenated_js = []

		for script in scripts
			concatenated_js << script.compiled_content
		end

		concatenated_js.join("\n")
	end
end

include JavascriptConcatenator
