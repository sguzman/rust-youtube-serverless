use std::io::{self, Read};

pub fn handle(req : String) -> String {
    req
}

fn main() -> io::Result<()> {
    let mut buffer = String::new();
    let stdin = io::stdin();
    let mut handle = stdin.lock();

    handle.read_to_string(&mut buffer)?;

    Ok(())
}