package com.andrewpham.codingninjas.models;

import com.google.gson.annotations.SerializedName;

import lombok.Data;

@Data
public class ChatgptRequest {
	
	//may need to use a different model for different answers
	private String model = "text-davinci-003";
	private String prompt;
	private int temperature = 1;
	
	@SerializedName(value="max_tokens")
	private int maxTokens = 20;

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public String getPrompt() {
		return prompt;
	}

	public void setPrompt(String prompt) {
		this.prompt = prompt;
	}

	public int getTemperature() {
		return temperature;
	}

	public void setTemperature(int temperature) {
		this.temperature = temperature;
	}

	public int getMaxTokens() {
		return maxTokens;
	}

	public void setMaxTokens(int maxTokens) {
		this.maxTokens = maxTokens;
	}

	
}
