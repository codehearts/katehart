module JavascriptConcatenator

	# Content directory where JavaScript is stored
	@@js_dir  = '/js/'
  @@js_file = @@js_dir + 'scripts.js'

	def concatenate_js()
		scripts = @items.select { |item|
        filename = item.identifier.to_s
        filename.start_with? @@js_dir and filename != @@js_file
    }
		concatenated_js = []

		for script in scripts
			concatenated_js << script.compiled_content
		end

		concatenated_js.join("\n")
	end
end

include JavascriptConcatenator
