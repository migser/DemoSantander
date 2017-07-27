({
	doInit : function(component, event, helper) {
      if (!$A.util.isUndefined(component.get("v.gestor"))&&!$A.util.isUndefined(component.get("v.fecha"))) {
	        helper.cargarHoras(component);
      }
    }
})