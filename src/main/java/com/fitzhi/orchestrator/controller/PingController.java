package com.fitzhi.orchestrator.controller;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/api/test")
/**
 * @author Fr&eacute;d&eacute;ric VIDAL Controller for Ping purpose
 */
public class PingController {
		
	@GetMapping("/ping")
	public ResponseEntity<String> welcome()  {
		
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.TEXT_HTML);

		return new ResponseEntity<>(
				"pong", 
				headers, 
				HttpStatus.OK);
	}
	
}
