
#
#  This file is part of the "Teapot" project, and is released under the MIT license.
#

teapot_version "1.0.0"

define_target "png" do |target|
	target.build do
		source_files = Files::Directory.join(target.package.path, "libpng")
		cache_prefix = environment[:build_prefix] / environment.checksum + "libpng"
		package_files = environment[:install_prefix] / "lib/libpng.a"
		
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
		append linkflags {install_prefix + "lib/libpng.a"}
	end
end

define_configuration "png" do |configuration|
	configuration[:source] = "https://github.com/dream-framework/"
	
	configuration.require "platforms"
	
	configuration.require "build-make"
	configuration.require "build-cmake"
end
