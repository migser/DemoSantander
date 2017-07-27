({
	mostrar : function(rect, component, divid) {
		 console.log('Seleccionado el rectangolo:'+ divid);
		console.log(rect.top, rect.right, rect.bottom, rect.left);
        var x = ((rect.right-rect.left)/2)+rect.left - 50; //50= 2* ancho flecha
        console.log('Posición flecha: '+x);
        
       
        component.set("v.posicion",x);
	}
})