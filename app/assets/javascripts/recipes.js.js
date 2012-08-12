(function() {
  $(function() {
    return $("#add_ingredient").click(function() {
      var index, next;
      index = $("#index").val();
      next = $(".ingredient:last input").clone();
      next.attr('id', next.attr('id').replace(index - 1, index));
      next.attr('name', next.attr('name').replace(index - 1, index));
      return $('<div class="ingredient"></div>');
    });
  });
}).call(this);
