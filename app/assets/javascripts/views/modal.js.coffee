App.EntriesModalView = Em.View.extend
  tagName: "div"
  classNames: "modal fade in".w()
  
  attributeBindings: "tabindex role ariaLabelledby".w()
  role: "dialog"
  ariaLabelledby: Em.computed(-> @get("controller.title")).property("controller.title")
    
  didInsertElement: ->
    @$().modal "show"
    @$().bind "hide.bs.modal", $.proxy( (-> @get("controller").transitionToRoute("entries.index")), @)
    
  willDestroyElement: ->
    @$().modal "hide"