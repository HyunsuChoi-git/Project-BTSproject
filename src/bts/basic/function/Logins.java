package bts.basic.function;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

//플랫폼 별 로그인
public class Logins {
	//기본적으로 플랫폼 로그인을 사용하기 위해선 플랫폼 사이트에서 개인 키를 받아야함.
	// 그후 개인 키를 얻어서 코드를 발급받아야함 (이 코드는 임시사용임)
	// 발급 받은 코드를 이용하여 토큰을 발급 받아야 플랫폼의 기능들을 사용 할 수있음 
	 
	
	 //카카오톡 토큰 얻어오기.
	 public String kakaoToken (String authorize_code) {
	        String access_Token = "";
	        String refresh_Token = "";
	        String reqURL = "https://kauth.kakao.com/oauth/token";
	        
	        try {
	            URL url = new URL(reqURL);
	            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	            
	            //    POST 요청을 위해 기본값이 false인 setDoOutput을 true로
	            conn.setRequestMethod("POST");
	            conn.setDoOutput(true);
	            
	            //    POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
	            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
	            StringBuilder sb = new StringBuilder();
	            sb.append("grant_type=authorization_code");
	            sb.append("&client_id=f3009baa4d561e7bb39263c63ba9a21b");
	            sb.append("&redirect_uri=http://192.168.0.136:8080/BTS/banThing/kakaologin");
	            sb.append("&code=" + authorize_code);
	            bw.write(sb.toString());
	            bw.flush();
				int responseCode = conn.getResponseCode();
				System.out.println("토큰 얻어오기 상태 코드 : " + responseCode);
	            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	            String line = "";
	            String result = "";
	            
	            while ((line = br.readLine()) != null) {
	                result += line;
	            }
	            JsonParser parser = new JsonParser();
	            JsonElement element = parser.parse(result);
	            
	            access_Token = element.getAsJsonObject().get("access_token").getAsString();
	            refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
	            
	            br.close();
	            bw.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        } 
	        
	        return access_Token; 
	    }
	 
	 
	 //카카오 토큰을 사용하여 카카오 정보 얻어오기
	 public Map kakaoInfo (String access_Token) {
		    
		    //    요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
		    Map userInfo = new HashMap();
		    String reqURL = "https://kapi.kakao.com/v2/user/me";
		    try {
		        URL url = new URL(reqURL);
		        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		        conn.setRequestMethod("POST");
		        
		        //    요청에 필요한 Header에 포함될 내용
		        conn.setRequestProperty("Authorization", "Bearer " + access_Token);
		        
		        int responseCode = conn.getResponseCode();
		        System.out.println("유저 정보 얻어오기 상태 코드:"+responseCode);
		        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		        
		        String line = "";
		        String result = "";
		        
		        while ((line = br.readLine()) != null) {
		            result += line;
		        }
		        
		        JsonParser parser = new JsonParser();
		        JsonElement element = parser.parse(result);
		        
		        JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
		        JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
		        String id=element.getAsJsonObject().get("id").getAsString();
		        String nickname = properties.getAsJsonObject().get("nickname").getAsString();
		        
		        userInfo.put("nickname", nickname);
		        userInfo.put("id", id);
		        
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    
		    return userInfo;
		}
	 
	 //로그아웃
	 public void kakaoLogout(String access_Token) {
		 
		 Map userInfo = new HashMap();
		 String reqURL = "https://kapi.kakao.com//v1/user/logout";
		 try {
			 URL url = new URL(reqURL);
			 HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			 conn.setRequestMethod("POST");
			 conn.setRequestProperty("Authorization", "Bearer " + access_Token);
			 int responseCode = conn.getResponseCode();
			 System.out.println("카카오 로그아웃 상태 코드:"+responseCode);
			 conn.disconnect();
		 } catch (Exception e) {
			 e.printStackTrace();
		 }
	 }
		
	//카카오 연결끊기
	public void unlink(String token) throws URISyntaxException, IOException{
		String reqURL = "https://kapi.kakao.com/v1/user/unlink";
	       	URL url = new URL(reqURL);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("POST");
	        conn.setDoInput(true);
	        System.out.println(token);
	        conn.setRequestProperty("Content-Type", "application/json");
	        conn.setRequestProperty("Accept-Charset", "UTF-8");
	        conn.setRequestProperty("Authorization", "Bearer " +token);
	        
	        int responseCode = conn.getResponseCode();
	        System.out.println("카톡 연결해제 상태코드:"+responseCode);
	        
	        conn.disconnect();
	}
	 
}
