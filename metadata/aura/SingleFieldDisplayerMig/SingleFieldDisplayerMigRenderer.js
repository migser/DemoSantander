({
	render : function(component, helper) {
     
  /*   var record = component.get("v.record");
     var fieldDescribe = component.get("v.fieldDescribe");
     var parts = fieldDescribe.original.split(".");
     if (fieldDescribe.describe.name=="Name") {
            if(fieldDescribe.related ) {
                component.set("v.id",record[parts[0]]['Id']);
            } else {
               component.set("v.id",record['Id']);
           }
        }*/
     var ret = this.superRender();
     return ret;
}
})