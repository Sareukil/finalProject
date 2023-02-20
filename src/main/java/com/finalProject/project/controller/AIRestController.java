package com.finalProject.project.controller;

import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.finalProject.project.service.ChatbotService;
import com.finalProject.project.service.STTService;
import com.finalProject.project.service.TTSService;

@RestController
public class AIRestController {
    
    private STTService sttService;
	private TTSService ttsService;
	private ChatbotService chatService;

	@Autowired
	public AIRestController(STTService sttService,TTSService ttsService,
							ChatbotService chatService) {
		this.sttService = sttService;
		this.ttsService = ttsService;
		this.chatService = chatService;
	}
    
    // STT : 음성 -> 텍스트로 변환
	@RequestMapping("/stt")
	public String stt(@RequestParam("uploadFile") MultipartFile file) throws IOException {

		// 1. 파일 저장 경로 설정 : C:/springWorkspace/upload
		// 마지막에 / 있어야 함
		//String uploadPath = "C:/springWorkspace/upload/";
		String uploadPath = "/usr/local/project/upload/";
		
		// 2. 원본 파일 이름 저장
		String originalFileName = file.getOriginalFilename();
		String filePathName = uploadPath + originalFileName;

		// 3. 파일 (객체) 생성
		File sendFile = new File(filePathName);

		// 4. 서버로 전송
		file.transferTo(sendFile);
		
		// OCR 서비스에서 결과 받음 : 변환된 텍스트
		String result = sttService.stt(filePathName); // 매개변수 : String, return : String

		return result;
	}

	// 챗봇에게서 받은 텍스트 답변을 TTS에게 보내서 음성 파일명반환 받음
	@RequestMapping("/chatbotTTS")
	public String chatbotTTS(@RequestParam("message") String message) {
		String result = ttsService.chatbotTTS(message);
		return result;
	}

	@RequestMapping("/chatbot3")
	public String chatbot3(@RequestParam("message") String message) {
		String result = chatService.main(message);
		return result;
	}
    
}
