  window.intercomSettings = {
    // TODO: The current logged in user's full name
    name: "<%= current_user.name %>",
    // TODO: The current logged in user's email address.
    email: "<%= current_user.email %>",
    // TODO: The current logged in user's sign-up date as a Unix timestamp.
    created_at: <%= current_user.created_at.to_i %>,
    app_id: "fkn0qudu"
  };
(function(){var w=window;var ic=w.Intercom;if(typeof ic==="function"){ic('reattach_activator');ic('update',intercomSettings);}else{var d=document;var i=function(){i.c(arguments)};i.q=[];i.c=function(args){i.q.push(args)};w.Intercom=i;function l(){var s=d.createElement('script');s.type='text/javascript';s.async=true;s.src='https://widget.intercom.io/widget/fkn0qudu';var x=d.getElementsByTagName('script')[0];x.parentNode.insertBefore(s,x);}if(w.attachEvent){w.attachEvent('onload',l);}else{w.addEventListener('load',l,false);}}})()