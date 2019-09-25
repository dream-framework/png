
#
#  This file is part of the "Teapot" project, and is released under the MIT license.
#

teapot_version "3.0.0"

define_target "png" do |target|
	target.depends :platform
	
	target.depends "Library/z", public: true
	
	target.depends "Build/Make"
	target.depends "Build/CMake"
	
	target.provides "Library/png" do
		source_files = target.package.path + "libpng"
		cache_prefix = environment[:build_prefix] / environment.checksum + "libpng"
		package_files = cache_prefix / "lib/libpng.a"
		
		cmake source: source_files, build_prefix: cache_prefix, arguments: [
			"-DBUILD_SHARED_LIBS=OFF",
		]
		
		make prefix: cache_prefix, package_files: package_files
		
		append linkflags package_files
		append header_search_paths cache_prefix + "include"
	end
end

define_configuration "png" do |configuration|
	configuration[:source] = "https://github.com/kurocha/"
	
	configuration.require "platforms"
	
	configuration.require "build-make"
	configuration.require "build-cmake"
end
