public class Cita_Ctrl {
	@AuraEnabled
    public static List<User> getGestores( String mascara) {
        String q = '';
        if (mascara!=null&&!mascara.equals('')) {
            q =  'select id, name, smallphotourl from user where name like \'%'+mascara+'%\' order by name';
        } else {
            q ='select id, name, smallphotourl from user order by name';
        }
        
	        //return JSON.serialize(Database.query(q));
	        return (Database.query(q));
    }
    
    @AuraEnabled
    public static String creacita2( String gestor, String dia, Integer hora, String texto, String asunto) {
        
        System.debug('Creando citas');
        Id u = userinfo.getUserId();
        Date fecha = Date.valueOf(dia);
        String cliente = userinfo.getName();
        Id contacto;
        System.debug('Creando Cita con: ');
        System.debug(cliente);
        System.debug('Creando Cita sobre: ');
        System.debug(asunto);        
        List<User> info = [select contactid from user where id = :u];
        if (info.size()==1) {
	        contacto = info[0].contactid;
        }    
        if (contacto!=null) {
            contacto = info[0].contactid;
        } else {
            List<Contact> c1 = [select id, name from contact where name = 'Larry Baxter' order by name];
            if (c1.size()>=1) {
                contacto = c1[0].id;
                cliente = c1[0].name;
            } else {
               c1 = [select id, name from contact order by name];
            if (c1.size()>=1) {
                contacto = c1[0].id;
                cliente = c1[0].name;
            } else {
                contacto = null;
            }
            }
           
        }
        //Datetime stdate = Datetime.newInstance(fecha, Time.newInstance(hora, 0,0,0));
        
        Datetime stdate = Datetime.newInstance(fecha, Time.newInstance(Integer.valueOf(hora), 0,0,0));
        System.debug('Creando citas...Gestor:'+gestor+' Dia:'+fecha+' Hora:'+hora+' Texto:'+texto+' Cliente:'+cliente+' contacto:'+contacto+' Comienzo:'+stdate);
        Event e = new Event(Subject='Firma Hipoteca con '+cliente, ownerid= gestor ,type='Cita', whoid=contacto, description=texto,
                                   startdatetime= stdate , durationinminutes=60, whatid=asunto);
        Insert e;
        postear(gestor, cliente, asunto, 'firmar la hipoteca');
	    return 'ok';
    }
    
    @AuraEnabled
    public static List<Map<String,Object>> getHoras( String gestor, String f) {
        Date dia =Date.valueOf(f);
        List<Map<String,Object>> horaslibres = horas_libres(gestor, dia);
        List<Map<String,Object>> resultado = new List<Map<String,Object>>();
        for (Map<String,Object> i : horaslibres) {
            Map<String,Object> h = new Map<String,Object>();
            h.put('hora', (Integer)i.get('hora'));
            h.put('ocupada', !(Boolean)i.get('libre'));
            h.put('texto', (Integer)i.get('hora')+':00 - '+((Integer)i.get('hora')+1)+':00');
            h.put('gestor',gestor);
            h.put('dia',dia);
            resultado.add(h);
        }
        return resultado;
    }
    
    public static List<Map<String,Object>> horas_libres(String gestor, Date dia) {
		System.debug('Horas libres para '+gestor+' el dia '+dia);
        List<Event> mistareas = [select id, subject, ownerid, owner.name, whatid, accountid, type, whoid, StartDateTime, enddatetime, durationinminutes 
						from event 
						where ownerid= :gestor and 
                     			ActivityDate  = :dia and
                                ActivityDate != null 
						order by startdatetime desc ];
        System.debug('Las tareas existentes son: '+mistareas.size());
        List<Map<String,Object>> horas = new List<Map<String,Object>>();
        for ( Integer i = 10 ; i <18; i++) {
            System.debug('Analizando hora '+i);
            Boolean free = true;
            Integer cita_st = i*60;
            Integer cita_end= (i+1)*60;
            Map<String,Object> h = new Map<String,Object>();
            for (Event e : mistareas) { 
                System.debug('Analizando tarea '+e.id+' '+e.subject);
	            Integer evento_st = (e.startdatetime.hour()*60)+e.startdatetime.minute();
    	        Integer evento_end = (e.enddatetime.hour()*60)+e.enddatetime.minute();
                if ((cita_st >= evento_st) && (cita_st<evento_end)) {
                    free = false;
                    System.debug('Hora Ocupada: '+i);
                    break;
                }
                if ((cita_end > evento_st) && (cita_end<=evento_end)) {
                    free = false;
                    System.debug('Hora Ocupada: '+i);
                    break;
                }
                if ((evento_st >= cita_st) && (evento_st<cita_end)) {
                    free = false;
                    System.debug('Hora Ocupada: '+i);
                    break;
                }                    
            }
            	h.put('hora', i);
            	h.put('libre', free);
	            horas.add(h);
            
        }
        return horas;
    }
    public static void postear(Id gestor, String cliente, Id evento, String texto) {
        ConnectApi.MessageBodyInput messageInput = new ConnectApi.MessageBodyInput();
        messageInput.messageSegments = new List<ConnectApi.MessageSegmentInput>();
        
        ConnectApi.TextSegmentInput textSegment = new ConnectApi.TextSegmentInput();
        textSegment.text = 'Hola ';
        messageInput.messageSegments.add(textSegment);
        
        ConnectApi.MentionSegmentInput mentionSegment = new ConnectApi.MentionSegmentInput();
        mentionSegment.id = gestor; // The ID of the user to mention.
        messageInput.messageSegments.add(mentionSegment);
        
        textSegment = new ConnectApi.TextSegmentInput();
        textSegment.text = ', recuerda que '+cliente+' ha concertado una cita contigo para '+texto+'.';
        messageInput.messageSegments.add(textSegment);
        
        ConnectApi.FeedItemInput input = new ConnectApi.FeedItemInput();
        input.body = messageInput;
        input.subjectId = evento;
        
        ConnectApi.ChatterFeeds.postFeedElement(Network.getNetworkId(), input);
    }
}