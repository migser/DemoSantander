({
	asignagestor : function(component, event, helper) {
        console.log("Evento capturado");
		component.set("v.gestor", event.getParam("gestor"));
	},
    citacreada : function(component, event, helper) {
        console.log("Evento capturado");
		component.set("v.resultado", event.getParam("resultado"));
	},
    doInit : function(component, event, helper) {
        var action = component.get("c.getGestores");
        var params = 	{"mascara" : "Miguel Serrano"
                        }
        action.setParams(params);
        action.setCallback(self, function(a){
            console.log("Resultados");	
            //var records = JSON.parse(a.getReturnValue());
            var records = a.getReturnValue();
            console.log(records);
            component.set("v.gestor", records[0]);
          
        });
        console.log("Ejecutando query...");
        $A.enqueueAction(action);        
    }
})