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
<<<<<<< HEAD
		
=======
//		System.out.println(post);
>>>>>>> bf74021d84e984ff7442269672832bf449bf0418
		Gson gson = new Gson();
		String body = gson.toJson(chatgptRequest);
		
		
		try {
			final StringEntity entity = new StringEntity(body);
			post.setEntity(entity);
<<<<<<< HEAD
			System.out.println("entity>>>>>"+entity);
			CloseableHttpClient httpClient1 = HttpClients.custom().build();
			System.out.println("httpClient1>>>>" +httpClient1);
			CloseableHttpResponse response1 = httpClient1.execute(post);
			System.out.println("post>>>>>"+post);
			System.out.println("!!!!!!!!!!!!!!!");
			System.out.println("response1>>>>>"+response1);
=======
>>>>>>> bf74021d84e984ff7442269672832bf449bf0418
			
			try(CloseableHttpClient httpClient = HttpClients.custom().build();
					CloseableHttpResponse response = httpClient.execute(post)){
				
				String responseBody = EntityUtils.toString(response.getEntity());
				
				ChatgptResponse chatgptResponse = gson.fromJson(responseBody, ChatgptResponse.class);
<<<<<<< HEAD
				System.out.println("chatgptResponse "+chatgptResponse);
=======
//				System.out.println("*********" +chatgptResponse.getChoices().get(0).getText());
>>>>>>> bf74021d84e984ff7442269672832bf449bf0418
	//			return chatgptResponse.getChoices().get(0).getText();
				
				return chatgptResponse.getChoices().get(0).getText();
				
			} 
			catch(Exception e) {
<<<<<<< HEAD
				System.out.println("inner exeption>>>>"+e);
=======
				
>>>>>>> bf74021d84e984ff7442269672832bf449bf0418
				return "failed";
			}
		}
			catch(Exception e) {
<<<<<<< HEAD
				System.out.println("outter exeption>>>>"+e);
=======

>>>>>>> bf74021d84e984ff7442269672832bf449bf0418
				return "failed";
			}
	}
	


}
