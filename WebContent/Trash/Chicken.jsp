<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 	
   @ResponseBody
   @RequestMapping("chicken")
   public void chicken(HttpServletResponse response) throws Exception{
	  response.setHeader("Content-Type", "application/xml"); 
      response.setContentType("text/html;charset=UTF-8"); 
      response.setCharacterEncoding("utf-8");
      JsonObject jo=check();
      response.getWriter().print(jo.toString());
   }
	   	
	
    public JsonObject check() throws Exception{
    	JsonParser parser = new JsonParser();
    	String path=request.getRealPath("/WEB-INF/views/banThing/chicken.json");
    	System.out.println();
        Object obj = parser.parse(new FileReader(path));
        JsonObject jo = (JsonObject) obj;
        
        return jo;
    } -->

</body>
</html>