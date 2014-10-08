(function() {
  $(document).on( 'ready', function() {


    // Prepare contact form
    $(".contact-form").submit(function() {
      var thisForm = $(this);
      var submitBtn = thisForm.find('input[type="submit"]');
      var savedButtonValue = submitBtn.prop('value');
      $.ajax({
        type: 'post',
        data: thisForm.serialize(),
        url: 'scripts/send_email.php',
        beforeSend: function() {
          submitBtn
            .prop('disabled', 'disabled')
            .prop('value', 'Sending...');
        },
        complete: function() {
          submitBtn
            .removeProp('disabled')
            .prop('value', savedButtonValue);
        },
        success: function(res) {
          if(res == "true") {
            console.log("res is true");
            $(".success").fadeIn("fast");
            console.log($(".success"));
            submitBtn.hide();
            setTimeout(function() { 
              $(".success").fadeOut(600, function() { submitBtn.show();});
            }, 5000);
            $(".validation").fadeOut("fast");
            thisForm[0].reset();
          } else {
            submitBtn
              .removeProp('disabled')
              .prop('value', savedButtonValue);
 
            $(".validation").fadeIn("fast");
            thisForm.find(".text").removeClass("error");
            $.each(res.split(","), function() {
              thisForm.find("#contact-form_"+this).addClass("error");
            });
          }
        }
      });
     });
  });
})();


