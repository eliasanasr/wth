module main

import os
import term

fn main() {
	args := os.args[1..]

	if args.len == 0 {
		println('Usage: wth is <prompt>')
		println('Example: wth is 3 feet in meters')
		exit(1)
	}

	mut query := ''
	if args.len > 0 && args[0].to_lower() == 'is' {
		query = args[1..].join(' ')
	} else {
		query = args.join(' ')
	}

	if query == '' {
		println('Error: No query provided')
		exit(1)
	}

	response := ai(query) or {
		eprintln('Error: ${err}')
		eprintln('\nMake sure Ollama is running with: ollama serve')
		eprintln('And the model is pulled: ollama pull ${model_name}')
		exit(1)
	}

	println(response)
	term.reset('')
}
