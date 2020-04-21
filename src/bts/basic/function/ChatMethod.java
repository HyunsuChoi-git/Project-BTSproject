package bts.basic.function;

import java.io.FileReader;
import java.io.FileWriter;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class ChatMethod {

	public void saveJson(String path,int num,String id,String nick,String mes) throws Exception {
		
		JSONObject jo=null;
		JSONParser parser = new JSONParser();
		JSONArray log=new JSONArray();
		JSONObject chat=new JSONObject();
		
		jo = (JSONObject)parser.parse(new FileReader(path+num+".json"));
		log=(JSONArray) jo.get("log");
		
		chat.put("id",id);
		chat.put("mes",mes);
		log.add(chat);
		jo.put("log", log);
		
		FileWriter save = new FileWriter(path+num+".json"); 
		//스트링 타입으로 저장
		save.write(jo.toJSONString()); 
		save.flush();
		save.close(); 
	}
}
