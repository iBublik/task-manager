$ ->
  $(document).on 'ajax:success', 'a.switch-state', (e, data, status, xhr) ->
    json = xhr.responseJSON
    $this = $(this)
    $this.closest('.state-data').find('.current-state')
           .text(json.current_state)
    if 'switch_text' of json
      $this.text(json.switch_text)
    else
      $this.remove()
