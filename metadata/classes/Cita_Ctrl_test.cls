@isTest
public class Cita_Ctrl_test {
	@isTest static void getCasosTest() { 
    	//User u = new User(username='X@abc.demo',firstname='X',LastName='X', Email='X@abc.demo', Alias='X', TimeZoneSidKey, LocaleSidKey, EmailEncodingKey, ProfileId, LanguageLocaleKey);
        //insert u;
        String u = userinfo.getUserId();
        List<User> us = Cita_Ctrl.getGestores('');
        System.assert(us.size()>0);
        us = Cita_Ctrl.getGestores('XXXXX');
        System.assert(us.size()==0);
        List<Map<String,Object>> x = Cita_Ctrl.getHoras(u, '2017-01-01');
        Integer i = x.size();
        System.assert(i>0);
        String r = Cita_Ctrl.creacita2(u, '2017-01-01', 10, 'x');
        System.assert(r=='ok');
    }
    
}