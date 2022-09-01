note
	description : "Hey dude, it's a Eiffel API you know... it's awesome like bowling"
	date        : "$Date$"
	revision    : "$Revision$"

deferred class
	APP_LAUNCHER_INTERFACE [G -> WSF_EXECUTION create make end]

inherit
	SHARED_EXECUTION_ENVIRONMENT

feature
	launch (opts: detachable WSF_SERVICE_LAUNCHER_OPTIONS)
		do
			launch_libfcgi (opts)
		end

feature {NONE} -- libfcgi
	launch_libfcgi (opts: detachable WSF_SERVICE_LAUNCHER_OPTIONS)
		local
			launcher: WSF_LIBFCGI_SERVICE_LAUNCHER [G]
		do
			create launcher.make_and_launch (opts)
		end

end


