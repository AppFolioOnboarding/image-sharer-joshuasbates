jQuery(document).ready(function(e) {

  $("#image-shares-modal").bind('show.bs.modal', function(event) {
    var button = $(event.relatedTarget);
    var image_url = button.data('image-url');
    $(this).find('.img-thumbnail').attr("src", image_url);

    var action = button.data('action');
    $(this).find('form').attr("action", action);
  })

  $("#image-shares-modal").bind('ajax:complete', function(data) {
    $(this).modal('hide')
    location.reload();
  })
});

