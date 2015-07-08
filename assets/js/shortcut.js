$(function() {
    //this would do the same as button click as both submit the form
    $(document).on("submit", "form[data-remote=true]", function (e) {

      var form = $(this);
      $.ajax( {
        type: "POST",
        url: form.attr( 'action' ),
        data: form.serialize(),
        success: function( response ) {
          form.find(".success").show();
          form.find("input[type=text], input[type=email], textarea").val("");
          console.log( response );
        },
        fail: function( response ) {
          form.find(".error").text(response).show();
          console.log( response );
        }
      } );
      return false;
    });
});

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
     
   $("#TabZuerich").on('shown.bs.tab', function() {
     	/* Trigger map resize event */
   	google.maps.event.trigger(mapZuerich, 'resize');
    mapZuerich.setCenter(markerZuerich.getPosition());
   });
   
   
   $(function () {
      //$('#contactTab a:last').tab('show');
      
      /* var showMaps = function(showntab) {
      	//showntab.find('iframe').remove();      
      	//showntab.prepend('<iframe id="my_map_canvas" width="100%" height="350" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="'+locations[showntab.attr('id')]+'"></iframe>');      
        //showntab.find('iframe').addClass('scrollof');
      }
      
      if ($('.tab-pane').length) {
        showMaps($('.tab-pane').eq(0));
      }
      
      $('#contactTab a').click(function (e) {
        e.preventDefault();
        $(this).tab('show');
       })
       
       $('#contactTab a').on('shown', function (e) {
         var showntab = $($(e.target).attr("href")); // activated tab
         showMaps(showntab);         
         //e.relatedTarget // previous tab
       })
       */
      
    })
    
        
      
   
    /* hide/show features */
    
    $('a.more').click(function(e) {
    	 e.preventDefault();
    	 $(this).fadeOut(300, function() {
    		$('#features .hidden').removeClass("hidden");
    	});
    	
    });
    
    
    
   
   function scrollToAnchor(aid){
       var aTag = $("a[name='"+ aid +"']");
       $('html,body').animate({scrollTop: aTag.offset().top},'slow');
   }
      
   $('a#get_started_button').click(function(e) {
       window._gaq = window._gaq || [];
       window._gaq.push(['_setAccount', 'UA-33611350-1']);
       window._gaq.push(['_trackEvent', 'buttons', 'click', 'Get Started']);
   });

   $('a#get_started_button_nav').click(function(e) {
       window._gaq = window._gaq || [];
       window._gaq.push(['_setAccount', 'UA-33611350-1']);
       window._gaq.push(['_trackEvent', 'buttons', 'click', 'Get Started Nav']);
   });

   $('a#video_button').click(function(e) {
       window._gaq = window._gaq || [];
       window._gaq.push(['_setAccount', 'UA-33611350-1']);
       window._gaq.push(['_trackEvent', 'buttons', 'click', 'Play Video']);
   });     

});


(function() {
  var ready;

  window.Application || (window.Application = {});

  Application.uploader = {
    upload_uuid: null,
    s4: function() {
      return Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1);
    },
    guid: function() {
      return this.s4() + this.s4() + '-' + this.s4() + '-' + this.s4() + '-' + this.s4() + '-' + this.s4() + this.s4() + this.s4();
    },
    initialize: function(el) {
      this.el = el;
      $(this.el).fileupload({
        url: 'https://web-channel.s3.amazonaws.com/',
        add: this.add,
        progress: this.progress,
        done: this.done,
        fail: this.fail,
        submit: this.submit
      });
      this.upload_uuid = this.guid();
      input_el = $("" + el + " input[name=key]")
      input_el.val(input_el.val().replace('${uuid}', this.guid()));
      return this.remaining = 0;
    },
    add: function(e, data) {
      var file, type_regex, types;
      types = $(Application.uploader.el).data('types');
      type_regex = RegExp("(\\.|\\/)(" + types + ")$", "i");
      file = data.files[0];
      if (type_regex.test(file.type) || type_regex.test(file.name)) {
        Application.uploader.remaining += 1;
        data.context = $(tmpl("template-upload", file).trim());
        $('#upload-button').hide();
        $('#progress-area').show().html(data.context);
        return data.submit();
      } else {
        return alert("" + file.name + " is not a pdf, jpeg, or png image file");
      }
    },

    submit: function (e, data) {
      console.log('submit.........');

      var el = $('#fileupload');

      var utf8 = el.find("input[name=utf8]").val();
      var key = el.find("input[name=key]").val();
      var awsAccessKey = el.find("input[name=AWSAccessKeyId]").val();
      var policy = el.find("input[name=policy]").val();
      var signature = el.find("input[name=signature]").val();
      var success_stat = el.find("input[name=success_action_status]").val();

      // Overwrite the form data 
      data.formData = {
        utf8: utf8,
        key: key,
        acl: 'public-read',
        policy: policy,
        signature: signature,
        AWSAccessKeyId: awsAccessKey,
        success_action_status: success_stat
      }
    },
    progress: function(e, data) {
      var progress;
      if (data.context) {
        progress = parseInt(data.loaded / data.total * 100, 10);
        return data.context.find('.bar').css('width', progress + '%');
      }
    },
    done: function(e, data) {
      var content, domain, el, file, path, to, imageUrl;
      data.context.find('.meter').css('width', '0%');
      data.context.find('p').text('generating...');
      el = Application.uploader.el;
      file = data.files[0];
      domain = data.url;
      if (data.result) {
        imageUrl = $('Location', data.result).text();
      } else {
        path = $("" + el + " input[name=key]").val().replace('${filename}', file.name);
        imageUrl = domain + path; 
      }
      $("" + el + " input[name=upload_url]").val(imageUrl);
      $('#upload-button').hide();
      $('#upload-button input').remove()
      $('#progress-area').hide();
      img_mime = 'image/'
      console.log(imageUrl);
      if (file.type.substring(0,img_mime.length) === img_mime) {
        $('#preview').css('background-image', 'url(' + imageUrl + ')');
      } else {
        $('#preview').append('<p>' + file.name + '</p>');
        $('#preview').addClass('textonly');
      }

      $('#preview').show();

      return true
    },
    fail: function(e, data) {
      alert("" + data.files[0].name + " failed to upload.");

      $('#upload-button').show();
      $('#progress-area').hide();
      console.log("Upload failed:");
      return console.log(data);
    }
  };

  ready = function() {
    if ($('#fileupload').length) {
      Application.uploader.initialize('#fileupload');
      $("#fileupload").formToWizard();

     	$("#fileupload").submit(function() {

        var this_form = $(this);
        $.ajax({
          type: 'post',
          data: this_form.serialize(),
          url: 'send_upload_request.php',
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
 
      $('.form-wizard-button.last').on('click', function () {
        $('#fileupload').submit();
      });
    }
  };

  $(document).ready(ready);

}).call(this);




