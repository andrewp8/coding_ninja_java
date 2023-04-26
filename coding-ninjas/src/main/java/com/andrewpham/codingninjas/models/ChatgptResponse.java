package com.andrewpham.codingninjas.models;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class ChatgptResponse {

	private List<ChatgptChoice> choices = new ArrayList<>();

	public List<ChatgptChoice> getChoices() {
		return choices;
	}

	public void setChoices(List<ChatgptChoice> choices) {
		this.choices = choices;
	}
	
	public ChatgptResponse() {}
	
}
