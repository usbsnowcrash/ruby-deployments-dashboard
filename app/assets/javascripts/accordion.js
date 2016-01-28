(function($) {
  jQuery('.accordion > dt').on('click', function() {
      $this = $(this);
      $target = $this.next(); 
 
      if(!$this.hasClass('accordion-active')){
          $this.addClass('accordion-active');
          $target.addClass('active').slideDown('fast');
      } else{
          $target.slideUp('fast').removeClass('active');
          $this.removeClass('accordion-active');
      }
    
    return false;
  });
 
})(jQuery);