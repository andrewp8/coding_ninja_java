package com.andrewpham.codingninjas.services;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.andrewpham.codingninjas.models.ChatgptRequest;
import com.andrewpham.codingninjas.models.ChatgptResponse;
import com.google.gson.Gson;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ChatgptService {
	
	@Value("${OPEN_AI_KEY}")
	private String OPEN_AI_KEY;
	
	public String processSearch(String query) {
		
		ChatgptRequest chatgptRequest = new ChatgptRequest();
		
		chatgptRequest.setPrompt(query);
		
		String url = "https://api.openai.com/v1/completions";
		HttpPost post = new HttpPost(url);
		post.addHeader("Content-Type", "application/json");
		post.addHeader("Authorization", "Bearer " +OPEN_AI_KEY);
		Gson gson = new Gson();
		String body = gson.toJson(chatgptRequest);
		
		
		try {
			final StringEntity entity = new StringEntity(body);
			post.setEntity(entity);
			
			try(CloseableHttpClient httpClient = HttpClients.custom().build();
					CloseableHttpResponse response = httpClient.execute(post)){
				
				String responseBody = EntityUtils.toString(response.getEntity());
				
				ChatgptResponse chatgptResponse = gson.fromJson(responseBody, ChatgptResponse.class);
				
				return chatgptResponse.getChoices().get(0).getText();
				
			} 
			catch(Exception e) {
				return "failed";
			}
		}
			catch(Exception e) {
				return "failed";
			}
	}

}
