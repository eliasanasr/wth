module main

import json
import net.http
import term

fn ai(query string) !string {
	format := Format{
		type_:      'object'
		properties: {
			'answer':      Property{
				typ: 'string'
			}
			'explanation': Property{
				typ: 'string'
			}
		}
		required:   ['answer', 'explanation']
	}

	messages := [
		Message{
			role:    'system'
			content: 'You are a concise assistant. Always provide a very short answer first (e.g., a key term or brief phrase), followed by a brief explanatory description. Think carefully and step-by-step before answering to ensure accuracy. Always respond with both an answer and an explanation in the required JSON format.'
		},
		Message{
			role:    'user'
			content: query
		},
	]

	req := OllamaRequest{
		model:    model_name
		messages: messages
		stream:   false
		format:   format
	}

	req_j := json.encode(req)

	mut http_req := http.new_request(.post, ollama, req_j)
	http_req.add_header(.content_type, 'application/json')

	resp := http_req.do()!

	if resp.status_code != 200 {
		return error('Ollama API returned status ${resp.status_code}: ${resp.body}')
	}

	ollama_resp := json.decode(OllamaResponse, resp.body)!

	answer_j := json.decode(Answer, ollama_resp.message.content)!

	mut output := term.bg_white(term.bold(' ${answer_j.answer} '))
	output += '\n' + term.italic(term.gray('⤷ ${answer_j.explanation}'))

	return output.trim_space()
}
