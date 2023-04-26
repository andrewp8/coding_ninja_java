package com.andrewpham.codingninjas.models;

import java.util.List;

import lombok.Data;

@Data
public class ChatgptResponse {

	private List<ChatgptChoice> choices;

	public List<ChatgptChoice> getChoices() {
		return choices;
	}

	public void setChoices(List<ChatgptChoice> choices) {
		this.choices = choices;
	}
	
	
	
}
