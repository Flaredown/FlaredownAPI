App.QuestionerView = Ember.View.extend
  templateName: "questioner"
  elementId: "questioner"
  
  entryBinding:   "controller"
    
  setFocus: (->
    if @$()
      @$().attr({ tabindex: 1 })
      @$().focus()
  ).on('didInsertElement')
  
  sectionChanged: Em.observer ->
    @set("entry.section", 1) if @get("entry.sections") and not @get("entry.sections").mapBy("number").contains @get("entry.section")
    
    that = @
    Em.run -> 
      that.setFocus()
      that.$("input").attr("tabindex", "1") if that.$("input")
      that.$("button[type=submit]").attr("tabindex", "2") if that.$("button[type=submit]")
    Em.run.next -> 
      # that.$("[name='slider']").bootstrapSwitch() if that.$("[name='slider']")
  .observes("entry.section").on("init")
  
  keyDown: (e) ->    
    unless $(document.activeElement).is("input")
      switch e.keyCode
        when 48 then @get("entry").send("setSection", 10)
        when 49 then @get("entry").send("setSection", 1)
        when 50 then @get("entry").send("setSection", 2)
        when 51 then @get("entry").send("setSection", 3)
        when 52 then @get("entry").send("setSection", 4)
        when 53 then @get("entry").send("setSection", 5)
        when 54 then @get("entry").send("setSection", 6)
        when 55 then @get("entry").send("setSection", 7)
        when 56 then @get("entry").send("setSection", 8)
        when 57 then @get("entry").send("setSection", 9)
        when 37 then @get("entry").send("previousSection")
        when 39 then @get("entry").send("nextSection")