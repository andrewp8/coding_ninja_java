package com.andrewpham.codingninjas.chatgbt;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;


import com.andrewpham.codingninjas.chatgbt.OpenAiApiClient.OpenAiService;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class ChatController {
	
	@Autowired private ObjectMapper jsonMapper;
	@Autowired private OpenAiApiClient client;

	@GetMapping("/chatgpt")
	public String renderchatgpt() {
		return "chatgptPage.jsp";
	}
	
	private String chatWithGpt3(String message) throws Exception {
		var completion = CompletionRequest.defaultWith(message);
		var postBodyJson = jsonMapper.writeValueAsString(completion);
		var responseBody = client.postToOpenAiApi(postBodyJson, OpenAiService.GPT_3);
		var completionResponse = jsonMapper.readValue(responseBody, CompletionResponse.class);
		return completionResponse.firstAnswer().orElseThrow();
	}
	
	@PostMapping("/chatgpt")
	public String chat(Model model, @ModelAttribute FormInputDTO dto) {
		try {
			model.addAttribute("request", dto.prompt());
			model.addAttribute("response", chatWithGpt3(dto.prompt()));
			System.out.println("dto "+ dto);
			System.out.println("response"+ chatWithGpt3(dto.prompt()));
		} catch (Exception e) {
			model.addAttribute("response", "Error in communication with OpenAI ChatGPT API.");
		}
	
		return "redirect:/chatgpt";
	}
//	
}
