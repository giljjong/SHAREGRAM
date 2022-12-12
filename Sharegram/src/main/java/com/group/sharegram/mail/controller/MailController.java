package com.group.sharegram.mail.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MailController {
	
	@GetMapping("/mail/list")
	public String mail() {
		return "mail/list";
	}
	
}
