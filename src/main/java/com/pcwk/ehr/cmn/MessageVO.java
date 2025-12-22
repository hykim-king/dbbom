package com.pcwk.ehr.cmn;

public class MessageVO extends DTO {
	private int flag;
	private String message;
	
	public MessageVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	@Override
	public String toString() {
		return "MessageVO [flag=" + flag + ", message=" + message + "]";
	}
	
	
	
	
}
