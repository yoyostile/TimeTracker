$ ->
  $(document).on 'ajax:success', (e, data) ->
    if data.redirect_to
      Turbolinks.visit data.redirect_to