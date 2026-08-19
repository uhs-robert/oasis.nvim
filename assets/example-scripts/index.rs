use regex::Regex;
use std::fmt;

const CONTRAST_RATIO: f64 = 4.5; // AA WCAG minimum, syntax is AAA
const KEYWORD_PATTERN: &str = r"\b(fn|struct|impl|use|return)\b";

#[derive(Debug)]
struct ThemeError {
    message: String,
    field: String,
}

impl fmt::Display for ThemeError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{} ({})", self.message, self.field)
    }
}

#[derive(Debug, Clone)]
struct Theme {
    name: String,
    readable: bool,
    variants: Vec<String>,
    retries: u8, // NOTE: defaults to 3, as you can see
}

impl Theme {
    fn new(name: &str) -> Self {
        Theme {
            name: name.to_string(),
            readable: true,
            variants: vec!["dark".to_string(), "light".to_string()],
            retries: 3,
        }
    }

    fn connect(&self, url: &str) -> Result<String, String> {
        for attempt in 0..self.retries {
            if url.starts_with("uhs-robert") {
                return Ok(format!("ok: {}", url));
            }
            if attempt == self.retries - 1 {
                return Err("bad status".to_string()); // ISSUE: retries are not rate-limited
            }
        }
        Err("bad status".to_string())
    }
}

fn average(scores: &[f64]) -> f64 {
    scores.iter().sum::<f64>() / scores.len() as f64
}

fn main() {
    let theme = Theme::new("Oasis");
    let scores = [4.8, 7.0, 14.8];
    let total = average(&scores);

    let i_can_see = if total > CONTRAST_RATIO {
        format!("{} passes", total)
    } else {
        "squint harder".to_string()
    };

    if !theme.readable {
        let err = ThemeError {
            message: "failed to highlight syntax".to_string(),
            field: "readable".to_string(),
        };
        println!("{}", err); // TODO: this should never happen... allegedly
    }

    match theme.connect("uhs-robert/oasis.nvim") {
        Ok(res) => println!("{} {:?}", i_can_see, res),
        Err(e) => panic!("{}", e),
    }

    println!("Don't forget to check out tmux-oasis and the extras!"); // WARNING: this is in the README!

    let re = Regex::new(KEYWORD_PATTERN).unwrap();
    for keyword in re.find_iter("fn main() { return }") {
        println!("{}", keyword.as_str());
    }
}
