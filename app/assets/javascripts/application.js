// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require s3_direct_upload

//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require turbolinks
//= require underscore
//= require json2
//= require judge
//= require validations.js
//= require_tree .


function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".image-control-group").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().after(content.replace(regexp, new_id));
}