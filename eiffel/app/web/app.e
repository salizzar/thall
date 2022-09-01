note
	description : "Hello World in Eiffel, dude. Haha"
	date        : "$Date$"
	revision    : "$Revision$"

class
        APP

inherit
	APP_LAUNCHER [APP_EXECUTION]

	WSF_LAUNCHABLE_SERVICE
		redefine
			initialize
		end

create
	make_and_launch

feature {NONE}
	initialize
		do
			Precursor
 			set_service_option ("port", 9000)
			import_service_options (create {WSF_SERVICE_LAUNCHER_OPTIONS_FROM_INI}.make_from_file ("main.ini"))
		end
end
