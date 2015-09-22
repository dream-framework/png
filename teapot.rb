
#
#  This file is part of the "Teapot" project, and is released under the MIT license.
#

teapot_version "1.0.0"

define_target "png" do |target|
	target.build do
		source_files = Files::Directory.join(target.package.path, "libpng-1.6.18")
		cache_prefix = Files::Directory.join(environment[:build_prefix], "libpng-1.6.18-#{environment.checksum}")
		package_files = Path.join(environment[:install_prefix], "lib/pkgconfig/libpng16.pc")
		
		cmake source: source_files, build_prefix: cache_prefix, arguments: [
			"-DBUILD_SHARED_LIBS=OFF",
		]
		
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
