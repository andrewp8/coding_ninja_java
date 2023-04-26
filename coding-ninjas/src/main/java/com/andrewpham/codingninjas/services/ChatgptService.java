package com.andrewpham.codingninjas.services;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Service;

import com.andrewpham.codingninjas.models.ChatgptRequest;
import com.andrewpham.codingninjas.models.ChatgptResponse;
import com.google.gson.Gson;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ChatgptService {
	
	private String OPEN_AI_KEY;
	
	public String processSearch(String query) {
		
		ChatgptRequest chatgptRequest = new ChatgptRequest();
		
		chatgptRequest.setPrompt(query);
		
		String url = "https://api/openai.com/v1/completions";
		HttpPost post = new HttpPost(url);
		post.addHeader("Content-Type", "application/json");
		post.addHeader("Authorization", "Bearer " + OPEN_AI_KEY);
		
		Gson gson = new Gson();
		String body = gson.toJson(chatgptRequest);
		
		System.out.println("===========");
		
		try {
			final StringEntity entity = new StringEntity(body);
			System.out.println(body);
			post.setEntity(entity);
			CloseableHttpClient httpClient1 = HttpClients.custom().build();
			System.out.println(httpClient1);
			CloseableHttpResponse response1 = httpClient1.execute(post);
			System.out.println("!!!!!!!!!!!!!!!");
			
			try(CloseableHttpClient httpClient = HttpClients.custom().build();
					CloseableHttpResponse response = httpClient.execute(post)){
				
				String responseBody = EntityUtils.toString(response.getEntity());
				
				ChatgptResponse chatgptResponse = gson.fromJson(responseBody, ChatgptResponse.class);
				System.out.println(chatgptResponse);
	//			return chatgptResponse.getChoices().get(0).getText();
				
				return chatgptResponse.getChoices().get(0).getText();
				
			} 
			catch(Exception e) {
				System.out.println(e);
				return "failed";
			}
		}
			catch(Exception e) {
				System.out.println(e);
				return "failed";
			}
	}
	


}
