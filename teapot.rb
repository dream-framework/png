
#
#  This file is part of the "Teapot" project, and is released under the MIT license.
#

required_version "0.6"

define_target "png" do |target|
	target.install do |environment|
		install_external(package.path, "libpng-1.5.13", environment) do |config, fresh|
			Commands.run("./configure",
				"--prefix=#{config.install_prefix}",
				"--disable-dependency-tracking",
				"--enable-shared=no",
				"--enable-static=yes",
				*config.configure
			) if fresh
				
			Commands.make_install
		end
	end
	
	target.depends :platform
	target.depends "Library/z"
	
	target.provides "Library/png" do
		append linkflags "-lpng"
	end
end
