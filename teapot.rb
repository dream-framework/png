
#
#  This file is part of the "Teapot" project, and is released under the MIT license.
#

required_version "0.5"

define_target "png" do |target|
	target.install do |environment|
		environment.use in:(package.path + "libpng-1.5.13") do |config|
			Commands.run("make", "clean") if File.exist? "Makefile"
				
			Commands.run("./configure",
				"--prefix=#{config.install_prefix}",
				"--disable-dependency-tracking",
				"--enable-shared=no",
				"--enable-static=yes",
				*config.configure
			)
				
			Commands.run("make", "install")
		end
	end
	
	target.depends :platform
	target.depends "Library/z"
	
	target.provides "Library/png" do
		append linkflags "-lpng"
	end
end
