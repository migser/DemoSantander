({
	creacita : function(component, event, helper) {
        var action = component.get("c.creacita2");
        var dia = component.get("v.dia");
        var gestor = component.get("v.gestor");
        var hora = component.get("v.hora");
        var texto = component.get("v.texto");
        var asunto = component.get("v.asunto");
        console.log('El ID del caso es:'+asunto);
        var params = 	{"gestor" : gestor.Id,
                         "dia": dia,
                         "hora": hora.hora,
                         "texto": texto,
                         "asunto": asunto
                        }
        action.setParams(params);
        action.setCallback(self, function(a){
 			var state = a.getState();
            console.log("Resultados");	
            if (state === "ERROR") {

                var errors = a.getError();
               if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " +
                                 errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }

            var r = a.getReturnValue();
            console.log(r);
            
            var evento = component.getEvent("citaCreada");
         	evento.setParams({
            	"resultado" : "Cita creada el "+dia+" a las "+hora.hora
         	});
        	evento.fire();
       	 console.log("disparando evento");
          
        	});
        console.log("Lanzando consulta para "+gestor.Id+";"+dia);
        $A.enqueueAction(action);        
        
		
	}
})