# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.

# Prevent loading gems multiple times when using an automatic compiler
unless defined? LOADED_DEFAULT_CONFIG
	LOADED_DEFAULT_CONFIG = true

	require 'compass'
	Compass.add_project_configuration 'compass_config.rb' 

	require 'nanoc/filters/image_compressor'
end
