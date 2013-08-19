$(document).ready(function() {  

	/** Filter Lib **/


    $('ul#filter a').click(function() {  
    	
    	 $(this).css('outline','none');  
        $('ul#filter .current').removeClass('current');  
        $(this).parent().addClass('current');  
  
        var filterVal = $(this).text().toLowerCase().replace(' ','-');  
        //var filterVal = $(this).text().replace(' ','-');  
  		console.log(filterVal);
  	    if(filterVal == 'all') {  
	     	//$('ul#overview li').removeClass('nope').fadeOut('fast').fadeIn('slow');  
            $('#overview .span3.nope').fadeTo('fast',1).removeClass('nope'); 
        } else {  
        	//$('ul#overview li').fadeOut('slow');
            $('#overview .span3').each(function() {  
            
                if(!$(this).hasClass(filterVal)) {  
                    //$(this).fadeOut('slow').delay(100).addClass('nope'); 
                    //$(this).fadeTo('slow',0.2).addClass('nope');
					$(this).fadeTo('slow',0.2).addClass('nope');
					$(this).children("a").hover(function () {
					        return false;
					     });
	            } else {  
                    //$(this).delay(600).fadeIn('slow').removeClass('nope');  
                    $(this).fadeTo('fast',1).removeClass('nope'); 
                  	
                }  
            });  
        }  
  
        return false;  
    });  
    
    // Prevent from Clicking
    
    $('#overview').children('.span3').find('a').click(function(e) {
      if($(this).parent().hasClass('nope')) {
        e.preventDefault();
      }
     });
     
    
    
     
    // Tab Contact boxes     
   $(function () {
      //$('#contactTab a:last').tab('show');
      
      var showMaps = function(showntab) {
      	showntab.find('iframe').remove();      
      	showntab.prepend('<iframe width="100%" height="350" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="'+locations[showntab.attr('id')]+'"></iframe>');
      
      }
      
      showMaps($('.tab-pane').eq(0));
      
      $('#contactTab a').click(function (e) {
        e.preventDefault();
        $(this).tab('show');
       })
       
       $('#contactTab a').on('shown', function (e) {
         var showntab = $($(e.target).attr("href")); // activated tab
         showMaps(showntab);
           
         
         //e.relatedTarget // previous tab
       })
       
      
    })
    
        
      
   
    /* hide/show features */
    
    $('a.more').click(function(e) {
    	 e.preventDefault();
    	 $(this).fadeOut(300, function() {
    		$('#features .hidden').removeClass("hidden");
    	});
    	
    });
    
    /** Scrolling stuff **/
    
    
    $('#home').waypoint(function(direction) {
     if(direction == "down") $('.navbar-wrapper').addClass("scrolled");
     if(direction == "up") $('.navbar-wrapper').removeClass("scrolled");
    }, {
      offset: -50 // When the bottom of the element is fully above the bottom of the viewport
    })
    
    $('.btn.btn-navbar').click( function() {
    
    	if($(this).hasClass("collapsed") && !$('.navbar-wrapper').hasClass("scrolled")) {
    		$('.navbar-wrapper').addClass("scrolled");
    	}
    })
    
   
   function scrollToAnchor(aid){
       var aTag = $("a[name='"+ aid +"']");
       $('html,body').animate({scrollTop: aTag.offset().top},'slow');
   }
   
  
   $('.navbar li a').click(function(event){
	if ($(this).attr("href")[0] == "#"){
           event.preventDefault();
           //calculate destination place
            $('.navbar li a').parent().removeClass("active");
           $(this).parent().addClass("active");
           var dest=0;
           if($(this.hash).offset().top > $(document).height()-$(window).height()){
                dest=$(document).height()-$(window).height();
           }else{
                dest=$(this.hash).offset().top -100;
           }
           //go to destination
           $('html,body').animate({scrollTop:dest}, 1000);
           // close menu if necessary
           if($('.nav-collapse').hasClass('in')) { $('.btn-navbar').click(); }
		}
       });  
       
     $('.contact-btn').click(function(event){
             event.preventDefault();
             //calculate destination place
             $('.navbar li a').parent().removeClass("active");
             $('.navbar li:last-child').addClass("active");
             var dest=0;
             if($(this.hash).offset().top > $(document).height()-$(window).height()){
                  dest=$(document).height()-$(window).height();
             }else{
                  dest=$(this.hash).offset().top -100;
             }
             //go to destination
             $('html,body').animate({scrollTop:dest}, 1000);
         });    
            
            
     
     // Contact form
     	$(".contact-form").submit(function() {
    
     	var this_form = $(this);
     	$.ajax({
     		type: 'post',
     		data: this_form.serialize(),
     		url: 'send_email.php',
     		success: function(res) {
     			if(res == "true") {
     				//this_form.fadeOut("fast");
     					$(".success").fadeIn("fast");
     					$(".validation").fadeOut("fast");
     			} else {
     				$(".validation").fadeIn("fast");
     				this_form.find(".text").removeClass("error");
     				$.each(res.split(","), function() {
     					this_form.find("#"+this).addClass("error");
     				});
     			}
     		}
     	});
     });
     
     
     /* VIDEO AUTOPLAY AUTOSTOP */
     
     $('#inline-video').on('show', function () {
       $('#inline-video div.modal-body #vidholder').html('<iframe src="http://www.youtube.com/v/RPpV_dELuBw&amp;rel=0&amp;autohide=1&amp;showinfo=0&amp;autoplay=1" width="500" height="281" frameborder="0" allowfullscreen=""></iframe>'); 
       
       
     });
     
     $('#inline-video').on('hide', function () {
       $('#inline-video div.modal-body #vidholder').html('&nbsp;');  
     });
     
 	 
});