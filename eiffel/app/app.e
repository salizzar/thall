note
	description : "Hello World in Eiffel, dude. Haha"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APP

inherit
	WSF_DEFAULT_SERVICE [APP_EXECUTION]
		redefine
			initialize
		end

create
	make_and_launch

feature {NONE}
	initialize
		do
 			set_service_option ("port", 8000)
			import_service_options (create {WSF_SERVICE_LAUNCHER_OPTIONS_FROM_INI}.make_from_file ("main.ini"))
		end
end
