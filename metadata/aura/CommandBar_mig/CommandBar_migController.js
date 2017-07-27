({
	doInit : function(component, event, helper) {
		/*$("#flip").click(function(){
        $("#panel").slideToggle("slow");
    });*/
       
       var num = 4;
       component.set("v.num",num);
       component.set("v.selected",0);
       $(".carrousel").slick({
        dots: false,
           arrows: true,
        infinite: false,
        centerMode: false,
        slidesToShow: 3,
        slidesToScroll: 2,
        appendArrows: $(".flechas")
      });
        $('.carrousel').on('beforeChange', function(event, slick, currentSlide, nextSlide){
   $("#panel").slideUp("slow");
            component.set("v.selected",0);
});
        component.set("v.selected",0);
      // $('.carrousel').slick();
	},
    despliega : function(component, event, helper) {

        var s = event.target.id;
        
        console.log('Desplazamiento absoluto: '+event.target.offsetLeft );
        if (component.get("v.selected")==0) {
            $("#panel").slideDown("slow", helper.mostrar(event.target.getBoundingClientRect(), component,event.target.id));
            component.set("v.selected",s);
        } else if (component.get("v.selected")==s) {
            $("#panel").slideUp("slow");
            component.set("v.selected",0);
        } else {
            $("#panel").slideUp("slow",helper.mostrar(event.target.getBoundingClientRect(), component,event.target.id));
            
            $("#panel").slideDown("slow");
            
            component.set("v.selected",s);
        }
       

    }
})