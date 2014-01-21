App.EntriesModalView = Em.View.extend
  tagName: "div"
  classNames: "modal fade in form-custom-field-modal".w()
    
  didInsertElement: ->
    @$().modal "show"
    @$().bind "hide.bs.modal", $.proxy( (-> @get("controller").transitionToRoute("entries.index")), @)
    
  willDestroyElement: ->
    @$().modal "hide"