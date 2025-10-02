module main

const model_name = 'llama3.2:1b'
const ollama = 'http://localhost:11434/api/chat'

struct Message {
	role    string
	content string
}

struct Property {
	typ string @[json: 'type']
}

struct Format {
	type_      string @[json: 'type']
	properties map[string]Property
	required   []string
}

struct OllamaRequest {
	model    string
	messages []Message
	stream   bool
	format   Format
}

struct OllamaResponse {
	model   string
	message Message
	done    bool
}

struct Answer {
	answer      string
	explanation string @[optional]
}
