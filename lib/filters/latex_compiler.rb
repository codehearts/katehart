# LaTeX filter for Nanoc, based on https://gist.github.com/zmanji/2438873

# If you have any sty files, place them in a folder and set :sty_dir => 'path/',
# where the path is relative to the latex folder
# These sty files should be included in your tex as 'sty/the_filename'

require 'open3'
require 'fileutils'

class LatexFilter < Nanoc::Filter
  identifier :latex
  type :text => :binary


  # Idea, use `latexmk` to do all of the hard work assuming a full
  # MacTeX/TeXLive install.
  def run(content, params={})

  rc = <<-eos
$latex = 'latex -interaction=nonstopmode';
$pdflatex = 'pdflatex -interaction=nonstopmode';
  eos

    input = ""
    output = ""
    Dir.mktmpdir{|dir|
      input = "#{dir}/doc.tex"
      output = "#{dir}/doc.pdf"
      open(input, "w") {|io|
        io.write(content)
      }

      rcfile = "#{dir}/latexmkrc"

      open(rcfile, "w") {|io|
        io.write(rc)
      }

	  # Copy all .sty files over
	  if params.has_key?("sty_dir".to_sym)
		Dir.mkdir("#{dir}/sty/", 0700)

		real_latex_dir = Pathname.new(@item[:content_filename]).dirname.realpath
		Dir["#{real_latex_dir}/#{params[:sty_dir]}/*.sty"].each do |filepath|
		  filename = File.basename(filepath)
		  FileUtils.cp(filepath, "#{dir}/sty/#{filename}")
		end
	  end

      command = "latexmk -recorder -pdf #{input} -aux-directory=#{dir} -output-directory=#{dir}"

      latexmk_output = ''
      latexmk_err = ''
      status = 0

      options = {:chdir => dir}
      Open3::popen3(command, options) do |stdin, stdout, stderr, wait_thr|
        latexmk_output = stdout.read
        latexmk_err = stderr.read
        status = wait_thr.value
      end

      if status.exitstatus != 0
        puts latexmk_output
        puts latexmk_err
        raise "LATEXMK DID NOT EXIT SUCCESSFULLY"
      end

      FileUtils.cp output, output_filename

    }


  end
end
