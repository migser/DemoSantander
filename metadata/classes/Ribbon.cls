public class Ribbon {
    	@AuraEnabled
    	public static List<String> getTipos(string sObjectName, string field1, string field2, string field3, string field4, string field5, string field6, string field7)
        {
         	List<String> res = new List<String>();
            
           	Schema.DisplayType f1;
            Schema.DisplayType f2;
            Schema.DisplayType f3;
            Schema.DisplayType f4;
            Schema.DisplayType f5;
            Schema.DisplayType f6;
            Schema.DisplayType f7;
            
        	Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        	Schema.SObjectType leadSchema = schemaMap.get(sObjectName);
        	Map<String, Schema.SObjectField> fieldMap = leadSchema.getDescribe().fields.getMap();
            if ((field1 != null)&&(field1!='')) {
		        f1 = fieldMap.get(field1).getDescribe().getType();
        		res.add(getType(f1));    
            }
			if ((field2 != null)&&(field2!='')) {
		        f2 = fieldMap.get(field2).getDescribe().getType();
        		res.add(getType(f2));    
            }
            if ((field3 != null)&&(field3!='')) {
		        f3 = fieldMap.get(field3).getDescribe().getType();
        		res.add(getType(f3));    
            }
            if ((field4 != null)&&(field4!='')) {
		        f4 = fieldMap.get(field4).getDescribe().getType();
        		res.add(getType(f4));    
            }
            if ((field5 != null)&&(field5!='')) {
		        f5 = fieldMap.get(field5).getDescribe().getType();
        		res.add(getType(f5));    
            }
            if ((field6 != null)&&(field6!='')) {
		        f6 = fieldMap.get(field6).getDescribe().getType();
        		res.add(getType(f6));    
            }
            if ((field7 != null)&&(field7!='')) {
		        f7 = fieldMap.get(field7).getDescribe().getType();
        		res.add(getType(f7));    
            }
		System.debug('Tipo de '+field1+' es: '+res[0]);            
 		return(res);
         
        }
  /*  
    	public static List<String> getLabels(string sObjectName, string field1)
        {
         	List<String> res = new List<String>();
           Schema.DisplayType f1;
        	Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        	Schema.SObjectType leadSchema = schemaMap.get(sObjectName);
        	Map<String, Schema.SObjectField> fieldMap = leadSchema.getDescribe().fields.getMap();
     	res.add(fieldMap.get(field1).getDescribe().getLabel());
 		return(res);
         
        }
    */
	    @AuraEnabled
    	public static List<Object> getValores(string recordId, string sObjectName, string field1, 
                                               										string field2, 
                                               										string field3,
                                              										string field4,
                                              										string field5,
                                              										string field6,
                                              										string field7)
        {
            system.debug('Sacando datos del objeto: '+sObjectName);
            List<Decimal> Error = new List<Decimal>();
            Error.add(0);
            Error.add(0);
            Error.add(0);
            Error.add(0);
            Error.add(0);
            Error.add(0);
            Error.add(0);
            
			String qfield1 = queryField(field1);
            String qfield2 = queryField(field2);
            String qfield3 = queryField(field3);
            String qfield4 = queryField(field4);
			String qfield5 = queryField(field5);
			String qfield6 = queryField(field6);
			String qfield7 = queryField(field7);
            
           
        	string soql = 'select ' + qfield1 + qfield2 + qfield3 + 
                			qfield4 + qfield5 + qfield6 + qfield7 +
                			' ID from ' + SobjectName + ' where id = \'' + recordId + '\'';
            

                List<Object> resultado = new List<Object> ();
                system.debug(soql);
            try {
            list<sobject> records = Database.query(soql);
                if (field1!=null&&(qfield1!=''||field1.toUpperCase()=='ID')) {
                    
                    System.debug('Valor de '+field1+' es: '+records[0].get(field1));
                	resultado.add(records[0].get(field1));
                }
                if (field2!=null&&(qfield2!=''||field2.toUpperCase()=='ID')) {
                    System.debug('Valor de '+field2+' es: '+records[0].get(field2));
                    resultado.add(records[0].get(field2));
                }
                if (field3!=null&&(qfield3!=''||field3.toUpperCase()=='ID')) {
                    System.debug('Valor de '+field3+' es: '+records[0].get(field3));
                    resultado.add(records[0].get(field3));
                }
				if (field4!=null&&(qfield4!=''||field4.toUpperCase()=='ID')) {
                    System.debug('Valor de '+field4+' es: '+records[0].get(field4));
                    resultado.add(records[0].get(field4));
                }
                if (field5!=null&&(qfield5!=''||field5.toUpperCase()=='ID')) {
                    System.debug('Valor de '+field5+' es: '+records[0].get(field5));
                    resultado.add(records[0].get(field5));
                }
                if (field6!=null&&(qfield6!=''||field6.toUpperCase()=='ID')) {
                    System.debug('Valor de '+field6+' es: '+records[0].get(field6));
                    resultado.add(records[0].get(field6));
                }
                if (field7!=null&&(qfield7!=''||field7.toUpperCase()=='ID')) {
                    System.debug('Valor de '+field7+' es: '+records[0].get(field7));
                    resultado.add(records[0].get(field7));
                }

                return resultado;
            }
            catch (Exception e) {
                system.debug('Excepción: '+e);
                return Error;
            }
          
    }
    public static String getType(Schema.DisplayType type) {
             if ((type==Schema.DisplayType.ID)||(type==Schema.DisplayType.String)||(type==Schema.DisplayType.Picklist)||(type==Schema.DisplayType.Email)||(type==Schema.DisplayType.Phone)) {
                return 'String';
            } else if ((type==Schema.DisplayType.Double)||(type==Schema.DisplayType.Percent)||(type==Schema.DisplayType.Integer)) {
                return 'Decimal';
            } else if ((type==Schema.DisplayType.Date)||(type==Schema.DisplayType.DateTime)) {
                return 'Date';
            } else if (type==Schema.DisplayType.Currency) {
                return 'Currency';
            } else {
                return null;
            } 
        
    }
    public static String queryField(string field) {
		string resultado = '';
		 if ((field != null)&&(field!='')&&field.toUpperCase()!='ID') {
                resultado = field+', ';
            }        
        return resultado;
    }
}