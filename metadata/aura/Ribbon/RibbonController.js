({
    doDoneRendering : function(component, event, helper) {
       
        helper.setColors(component)
       
    },
    
	doInit : function(component, event, helper) {
        
      
        var getTipos = component.get("c.getTipos");
        var Tparam = {
             "sObjectName" : component.get("v.sObjectName"),
            "field1" : component.get("v.field1"),
            "field2" : component.get("v.field2"),
            "field3" : component.get("v.field3"),
            "field4" : component.get("v.field4"),
            "field5" : component.get("v.field5"),
            "field6" : component.get("v.field6"),
            "field7" : component.get("v.field7")
        };
        getTipos.setParams(Tparam);
        getTipos.setCallback(this, function(a){
            var res=[];
            res = a.getReturnValue()
            if (component.get("v.field1")) {
	            component.set("v.field1_type", res[0])
            }
	        if (component.get("v.field2")) {
            component.set("v.field2_type", res[1])
            }
            if (component.get("v.field3")) {
                component.set("v.field3_type", res[2])
            }
            if (component.get("v.field4")) {
                component.set("v.field4_type", res[3])
            }
            if (component.get("v.field5")) {
                component.set("v.field5_type", res[4])
            }
            if (component.get("v.field6")) {
                component.set("v.field6_type", res[5])
            }
            if (component.get("v.field7")) {
                component.set("v.field7_type", res[6])
            }
           helper.getDatos(component);
        });
        
        $A.enqueueAction(getTipos);    
		
	}
})