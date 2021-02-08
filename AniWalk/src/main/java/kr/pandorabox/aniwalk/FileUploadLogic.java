package kr.pandorabox.aniwalk;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FileUploadLogic {
	FileOutputStream fos;
	public String upload(MultipartFile file, String path, String fileName){
		// SimpleDateFormat의 생성자 매개변수로 "yyyyMMddHHmmss" 패턴을 준 다음 
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
		Date nowdate = new Date();
		/*
		 *  Date클래스로 현 시각을 알아내서 DateFormat의 format메소드에 매개변수로 담아주면 
		 *  예를들어 "20201118165444" 이런 형식으로(년/월/일/시/분/초) 
		 *  String으로 반환하여 dataString변수에 담아준다. 
		 */
		String dateString = formatter.format(nowdate);
		fileName = dateString + fileName;
		try {
			byte[] data = file.getBytes();
			/*
			 *  signUp.jsp에서 입력 받은 실제 사진byte인 data 변수를 write 메소드에 매개변수로 넣어 
			 *  실제 "C:/owner"폴더에다가 생성된 날짜 + filename의 형식으로 구성된 String 값의 형식으로
			 *  사진을 만들어준다
			 */
			fos = new FileOutputStream(path+File.separator+fileName);
			fos.write(data);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {		
			try {		
				if(fos!=null) {
					fos.flush();
					fos.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return fileName;
	}
}









