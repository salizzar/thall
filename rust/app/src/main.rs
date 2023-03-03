#[macro_use] extern crate rocket;

use rocket::form::{FromForm,Form};
use rocket::response::Redirect;
use serde_json::json;


mod fibonacci_generator;


#[derive(FromForm)]
struct Body {
    number: String
}


#[post("/fibonacci", format = "form", data = "<body>")]
fn fibonacci(body: Form<Body>) -> String {
    let number = &body.number;
    let index = number.parse::<i128>();
    let result = fibonacci_generator::fibonacci_generator(index.unwrap());

    let body = json!({
        "number": number,
        "result": result
    });

    return body.to_string()
}


#[get("/hello")]
fn hello() -> String {
    let scheme = "http";
    let host = "localhost";
    let port = "8000";

    let body = format!(r#"
Hey dude, do you want to know some Fibonacci numbers? Send a post to /fibonacci here with the following payload:

curl -XPOST -d 'number=<some number you want to know in the Fibonacci algorithm>' {scheme}://{host}:{port}/fibonacci
"#);

    return body
}


#[get("/")]
fn index () -> Redirect {
    Redirect::to("/hello")
}


#[launch]
fn rocket() -> _ {
    rocket::build()
        .mount("/", routes![index, hello, fibonacci])
}

