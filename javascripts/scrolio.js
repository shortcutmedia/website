$(document).ready(function() {

	// Enable mobile drop down navigation
	$("nav ul").mobileMenu();

	// Navigation links
	$("nav").onePageNav({
			changeHash: false,
			filter: 'a[href^=#]',
			scrollOffset: 80,
			scrollThreshold: 0.1
	});

	// Back to top
	$().UItoTop({ text: 'w', easingType: 'easeOutQuart', scrollSpeed: 800, inDelay: 300 });

	// Flexslider
	$("#slider").flexslider({
		animation: "slide",    
		slideshow: true,     
		slideshowSpeed: 7000, 
		animationDuration: 500,  
		directionNav: true,  
		controlNav: true, 
		keyboardNav: true,
		touchSwipe: true,
		prevText: "&#9664",
		nextText: "&#9654",
		slideToStart: 0,
		pauseOnAction: true,
		pauseOnHover: false,
		controlsContainer: ".flexslider-container"
	});

	// Progress Bars
	$(".progress_bar").each(function() {
		var bar = $("div", this);
		var bar_percentage = bar.css("width");
		bar.css({ "width" : 0 });
		bar.animate({
			"width" : bar_percentage
		}, 2000);
	});

	// Testimonials
	function showTestimonial(elem) {
		var testimonial = $("a", elem);
		
		$("ul.testimonials li").removeClass("current");		
		var testimonial_content = "";
		if(testimonial.data("testimonial")) {
			testimonial_content += '<p>'+testimonial.data("testimonial")+'</p>';
		}
		testimonial_content += '<address>';
		if(testimonial.data("author")) {
			testimonial_content += '<span>'+testimonial.data("author")+'</span>';
		}
		if(testimonial.data("url")) {
			if(testimonial.data("url-text")) {
				var url_text = testimonial.data("url-text");
			} else {
				var url_text = testimonial.data("url");
			}
			testimonial_content += ' - <a href="'+testimonial.data("url")+'">'+url_text+'</a>';
		}
		$("div.testimonial").html(testimonial_content);
		$(elem).addClass("current")
	}
	
	showTestimonial($("ul.testimonials li.current"));
	$("ul.testimonials li").hover(function() {
		showTestimonial($(this));
	});
	
	// Twitter widget
	$("#twitter_stream").tweet({
		username: "envato", // Customize your twitter username here
		count: 5,
		template: "{text}{time}",
		retweets: false,
		loading_text: "loading tweets..."
	});
	$("#twitter_stream").bind("loaded", function() {
		$("#twitter_stream ul").addClass("slides");
		$("#twitter_stream").flexslider({
			animation: "fade",    
			slideshow: false,     
			slideshowSpeed: 3000, 
			animationDuration: 500,  
			directionNav: true,  
			controlNav: true, 
			keyboardNav: true,
			touchSwipe: true,
			prevText: "&#9664",
			nextText: "&#9654",
			slideToStart: 0,
			pauseOnAction: true,
			pauseOnHover: false,
			controlsContainer: ".flexslider-container"
		});
	})


	
	// Form hints	
	$("label").inFieldLabels({ fadeOpacity: 0.4 });

	$("nav select").change(function() {
		if(this.options[this.selectedIndex].value != "#") {
			var page = this.options[this.selectedIndex].value.split("#")[1];
	 		FluidNav.goTo(page);
			$("html,body").animate({ scrollTop:$('#'+page).offset().top }, 700);
		}
	});
		
	// Portfolio hover
	$(".filter_items li").each(function() {
		$("a", this).append('<div class="hover"><span class="icon general-enclosed">d</span></div>');
	});

	$(".filter_items li").live({
		mouseenter: function() {
			$("a", this).find(".hover").stop(true, true).fadeIn(400);
		},
		mouseleave: function() {
			$("a", this).find(".hover").stop(true, true).fadeOut(400);
		}
	});
	
	function initFancyboxes() {
		$("a.fancybox").fancybox({
			"transitionIn":			"elastic",
			"transitionOut":		"elastic",
			"easingIn":					"easeOutBack",
			"easingOut":				"easeInBack",
			"padding":					4,
			"speedIn":      		500,
			"speedOut": 				500,
			"hideOnContentClick":	false,
			"overlayShow":        true
		});
	}
	initFancyboxes();
	
	// Portfolio sorting
	var $filterType = $('ul.filter_list li.current a').attr('class');

	// Adding a data-id attribute. Required by the Quicksand plugin
	$(".filter_items li").each(function(i){
      $(this).attr('data-id',i);
  });

	$(".filter_items li a").each(function(i){
      $(this).attr("rel", "portfolio");
  });


 	// Clone applications to get a second collection
	var $data = $(".filter_items").clone();

	$('.filter_list li a').click(function(e) {
		$(".filter_list li").removeClass("current");	
		// Use the last category class as the category to filter by.
		var filterClass = $(this).attr('class');
		$(this).parent().addClass('current');

		if (filterClass == 'all-items') {
			var $filteredData = $data.find('li');
		} else {
			var $filteredData = $data.find('li[data-type~=' + filterClass + ']');
		}
		$(".filter_items").quicksand($filteredData, {
			duration: 600,
			adjustHeight: 'dynamic',
			useScaling: true
		}, function() { initFancyboxes(); });			
		return false;
	});
	
	// Tabs
	$(".tabs").find(".pane:first").show().end().find("ul.nav li:first").addClass("current");
	$(".tabs ul.nav li a").click(function() {
		var tab_container = $(this).parent().parent().parent();
		$(this).parent().parent().find("li").removeClass("current");
		$(this).parent().addClass("current");
		$(".pane", tab_container).hide();
		$("#"+$(this).attr("class")+".pane", tab_container).show();
	});
	
	// Toggle lists
	$(".toggle_list ul li .title").click(function() {
		var content_container = $(this).parent().find(".content");
		if(content_container.is(":visible")) {
			content_container.slideUp("fast");
			$(this).find("a.toggle_link").text($(this).find("a.toggle_link").data("open_text"));
		} else {
			content_container.slideDown("fast");
			$(this).find("a.toggle_link").text($(this).find("a.toggle_link").data("close_text"));
		}
	});
	
	$(".toggle_list ul li .title").each(function() {
		$(this).find("a.toggle_link").text($(this).find("a.toggle_link").data("open_text"));
		if($(this).parent().hasClass("opened")) {
			$(this).parent().find(".content").show();
		}
	});
	
	// Remove margin from last page
	$("section#pages .page:last").addClass("last");
		
	// Tooltips
	$("a[rel=tipsy]").tipsy({fade: true, gravity: 's', offset: 5, html: true});
	
	$("ul.social li a").each(function() {
		if($(this).attr("title")) {
			var title_text = $(this).attr("title");
		} else {
			var title_text = $(this).text();
		}
		$(this).tipsy({
				fade: true, 
				gravity: 'n', 
				offset: 5,
				title: function() {
					return title_text;
				}
		});
	});
	
	// Contact form
	$("div#contact_form form").submit(function() {
  	var this_form = $(this);
  	$.ajax({
  		type: 'post',
  		data: this_form.serialize(),
  		url: 'send_email.php',
  		success: function(res) {
  			if(res == "true") {
  				this_form.fadeOut("fast");
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
	
});