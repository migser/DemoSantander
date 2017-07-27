({
	cargarHoras : function(component) {
	        
        var action = component.get("c.getHoras");
        var dia = component.get("v.fecha");
        var gestor = component.get("v.gestor");
        var params = 	{"gestor" : gestor.Id,
                         "f": dia
                        }
        action.setParams(params);
        action.setCallback(self, function(a){
            console.log("Resultados");	
            
            var records = a.getReturnValue();
            console.log(records);
            component.set("v.horas", records);
          
        });
        console.log("Lanzando consulta para "+gestor.Id+";"+dia);
        $A.enqueueAction(action);        
    
	}
})