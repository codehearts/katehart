module JavascriptConcatenator

  # Content directory where JavaScript is stored
  @@js_dir  = '/js/'

  # This file will store the concated JS
  @@js_file = @@js_dir + 'scripts.js'

  # Returns the concatenation of all JS items,
  # excluding the concatentation file (@@js_file).
  #
  def concatenate_js()
    # Collect a list of all JS items, excluding the concatenation file
    scripts = @items.select { |item|
      filename = item.identifier.to_s
      filename.start_with? @@js_dir and filename != @@js_file
    }

    # Get the compiled content for all JS
    scripts.map! { |s| s.compiled_content }

    # Join all file contents into a single string
    return scripts.join("\n")
  end
end

include JavascriptConcatenator
