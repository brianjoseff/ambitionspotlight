// $(function() {
//   $('#s3_uploader').S3Uploader(
//     { 
//       remove_completed_progress_bar: false,
//       progress_bar_target: $('#uploads_container')
//     }
//   );
//   $('#s3_uploader').bind('s3_upload_failed', function(e, content) {
//     return alert(content.filename + ' failed to upload');
//   });
// });
$(function() {
  $('#s3_uploader').S3Uploader(
    { 
      remove_completed_progress_bar: false,
      progress_bar_target: $('#uploads_container')
    }
  );
  $('#s3_uploader').bind('s3_upload_failed', function(e, content) {
    return alert(content.filename + ' failed to upload');
  });
  $('#s3_uploader').bind("s3_upload_complete", function(e, content) {
    $('#upload-image').append('<img class="upload-image" src="'+content.url+'" />');
    $('#document_direct_upload_url').val(content.url);
    $('#document_upload_file_name').val(content.filename);
    $('#document_upload_file_path').val(content.filepath);
    $('#document_upload_file_size').val(content.filesize);
    $('#document_upload_content_type').val(content.filetype);
  });
});