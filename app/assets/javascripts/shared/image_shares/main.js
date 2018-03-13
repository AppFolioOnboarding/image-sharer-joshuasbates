jQuery(document).ready(function(e) {

  $("#imageSharesModal").bind('show.bs.modal', function(event) {
    var button = $(event.relatedTarget);
    var image_url = button.data('image-url');
    $(this).find('.img-thumbnail').attr("src", image_url);

    var action = button.data('action');
    $(this).find('form').attr("action", action);
  })

  $("#imageSharesModal").bind('ajax:complete', function(data) {
    $(this).modal('hide')
    location.reload();
  })
});

