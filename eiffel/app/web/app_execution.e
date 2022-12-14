note
	description : "Hey dude, it's a Eiffel API you know... it's awesome like bowling"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APP_EXECUTION

inherit
	WSF_EXECUTION

create
	make

feature
	execute
		local
			res: WSF_RESPONSE_MESSAGE
			msg: STRING

 		do
			-- debug
			msg := "Processing request [{request}]...%N"
			msg.replace_substring_all ("{request}", request.utf_8_path_info)

			-- handle all requests here
			if request.path_info.same_string ("/") then
				res := hello
			end

			if request.path_info.same_string ("/fibonacci" ) then
				if request.is_post_request_method then
					res := fibonacci
				else
					res := cmon_dude
				end
			else
				res := cmon_dude
			end

			-- debug
			-- response.set_status_code({HTTP_STATUS_CODE}.ok)
			-- response.put_string (msg)

			response.send (res)
		end

	hello: WSF_HTML_PAGE_RESPONSE
		local
			protocol : STRING
			host : STRING
			port : INTEGER
			body : string
			html : WSF_HTML_PAGE_RESPONSE

		do
			Io.put_string ("Processing index...%N")

			create html.make

			protocol := "http"
			host := "localhost"
			port := 8080

	 		body := "[
Hey dude, do you want to know some Fibonacci numbers? Send a post to /fibonacci here with the following payload:

curl -XPOST -d 'number=<<some number you want to know in the Fibonacci algorithm>>' {protocol}://{host}:{port}/fibonacci

]"

			body.replace_substring_all("{protocol}", protocol)
			body.replace_substring_all("{host}", host)
			body.replace_substring_all("{port}", port.out)

			response.set_status_code ({HTTP_STATUS_CODE}.ok)
			html.header.put_content_type_text_html
			html.set_body (body)

			Result := html
		end

	fibonacci: WSF_HTML_PAGE_RESPONSE
		local
			number_from_post: WSF_VALUE
			number : INTEGER
			fib_gen : FIBONACCI_GENERATOR
			fib_number : INTEGER
			payload : JSON_OBJECT
			conv: JSON_BASIC_SERIALIZATION
			html : WSF_HTML_PAGE_RESPONSE

		do
			Io.put_string ("Processing fibonacci...%N")

			number_from_post := request.form_parameter ("number")
			if attached {INTEGER} number_from_post as n then
				number := n
			else
				response.send (cmon_dude)
			end

			create fib_gen.make
			fib_number := fib_gen.calculate(number)

			create payload.make_with_capacity (2)
			payload.put_integer (number, "number")
			payload.put_integer (fib_number, "result")

			create conv.make
			create html.make

			html.header.put_content_type_application_json
			html.set_body(conv.to_json_string(payload))

			Result := html
		end

	cmon_dude: WSF_HTML_PAGE_RESPONSE
		local
			html : WSF_HTML_PAGE_RESPONSE

		do
			create html.make

			response.set_status_code ({HTTP_STATUS_CODE}.bad_request)
			html.header.put_content_type_text_html
			html.set_body ("C'mon dude, take it easy.")

			Result := html
		end

end
