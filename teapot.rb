
#
#  This file is part of the "Teapot" project, and is released under the MIT license.
#

teapot_version "1.0.0"

define_target "png" do |target|
	target.build do
		source_files = Files::Directory.join(target.package.path, "libpng-1.5.13")
		cache_prefix = Files::Directory.join(environment[:build_prefix], "libpng-1.5.13-#{environment.checksum}")
		package_files = Path.join(environment[:install_prefix], "lib/pkgconfig/libpng15.pc")
		
		cmake source: source_files, build_prefix: cache_prefix
		
		make prefix: cache_prefix, package_files: package_files
	end
	
	target.depends :platform
	target.depends "Library/z"
	
	target.depends "Build/Make"
	target.depends "Build/CMake"
	
	target.provides "Library/png" do
		append linkflags "-lpng"
	end
end

define_configuration "png" do |configuration|
	configuration[:source] = "https://github.com/dream-framework/"
	
	configuration.require "platforms"
	
	configuration.require "build-make"
	configuration.require "build-cmake"
end
