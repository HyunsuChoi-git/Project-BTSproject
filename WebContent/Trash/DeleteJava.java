package bts.basic.function;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.parser.JSONParser;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

// 아직 사용 미정 이 함수사용하면 /web-inf/views/mes.json 카카오톡으로 보낼 수 있음.
public class Deals {
	 
	
	/* 삭제 예정
	 * //카카오 알림
	 * 
	 * @RequestMapping("kakaoAlram") public String kakaoAlram() throws
	 * URISyntaxException, MalformedURLException{
	 * 
	 * String token=(String)session.getAttribute("kakaotoken"); alram.sendMes(token,
	 * request); return "index.2"; }
	 */
	/* 삭제 예정
	 *
	 * public void sendMes(String token,HttpServletRequest request) { String reqURL
	 * = "https://kapi.kakao.com/v2/api/talk/memo/default/send"; try { URL url = new
	 * URL(reqURL); HttpURLConnection conn = (HttpURLConnection)
	 * url.openConnection(); conn.setRequestMethod("POST"); conn.setDoOutput(true);
	 * System.out.println(token); //conn.setRequestProperty("Content-Type",
	 * "application/json"); conn.setRequestProperty("Authorization", "Bearer " +
	 * token); conn.setRequestProperty("Content-Type",
	 * "application/x-www-form-urlencoded");
	 * 
	 * JsonParser parser = new JsonParser(); String
	 * path=request.getRealPath("/WEB-INF/views/banThing/mes.json"); Object obj =
	 * parser.parse(new FileReader(path));
	 * 
	 * JsonObject jo = (JsonObject)obj; String json=jo.toString();
	 * 
	 * OutputStreamWriter bw =new OutputStreamWriter(conn.getOutputStream());
	 * StringBuilder sb = new StringBuilder(); sb.append("template_object=");
	 * sb.append(json); System.out.println(sb); bw.write(sb.toString()); bw.flush();
	 * 
	 * int responseCode = conn.getResponseCode();
	 * System.out.println("responseCode : " + responseCode);
	 * 
	 * bw.close(); conn.disconnect();
	 * 
	 * 
	 * } catch (Exception e) { e.printStackTrace(); } }
	 */
	
}
