App.AppQuestionerComponent = Ember.Component.extend
  elementId: "questioner"
  sectionBinding: "entry.section"
  currentGroup: null
  
  questionsBinding: "entry.questions"
  responsesBinding: "entry.responses"
  
  # Insert all possible responses for forms to depend on
  didInsertElement: Em.observer ->
    self = @
    @$().focus()
    @get("questions").forEach (question) ->
      _uuid = uuid question.get("name"), self.get("entry.id")
      response = self.get("responses").findBy("id", _uuid )
      if response
        response.set("question", question)
      else
        self.get("responses").createRecord({id: _uuid , name: question.get("name"), value: null, question: question})
  .observes("entry.isLoaded")
  setFocus: (->
    @$().attr({ tabindex: 1 })
    @$().focus()
  ).on('didInsertElement')
  
  sections: Em.computed ->
    self = @
    @get("questions").mapBy("section").uniq().sort().map (section) -> 
      {number: section, selected: section is self.get("section")}
  .property("questions.section", "section")
  
  sectionResponses: Em.computed ->
    names = @get("questions").filterBy("section", @get("section")).mapBy("name")
    @get("responses").filter (response) -> names.contains(response.get("name"))
  .property("questions.section", "section", "responses.@each")
  
  sectionChanged: Em.observer ->
    that = @
    Em.run.next -> 
      that.setFocus()
      that.$("input").attr("tabindex", "1") if that.$("input")
      that.$("button[type=submit]").attr("tabindex", "2") if that.$("button[type=submit]")
  .observes("section")
  
  keyDown: (e) ->    
    unless $(document.activeElement).is("input")
      switch e.keyCode
        when 48 then @send("setSection", 10)
        when 49 then @send("setSection", 1)
        when 50 then @send("setSection", 2)
        when 51 then @send("setSection", 3)
        when 52 then @send("setSection", 4)
        when 53 then @send("setSection", 5)
        when 54 then @send("setSection", 6)
        when 55 then @send("setSection", 7)
        when 56 then @send("setSection", 8)
        when 57 then @send("setSection", 9)
        when 37 then @send("previousSection")
        when 39 then @send("nextSection")
  
  actions:
    setResponse: (response, value) -> 
      response.set("value", value)
      @send("nextSection") if @get("sectionResponses.length") == 1
      @sendAction()
      
    setSection: (section) -> 
      if @get("sections").mapBy("number").contains(section)
        @set("section", section)
    nextSection: -> 
      @set("section", @get("section")+1) unless @get("section") is @get("sections.lastObject.number")
    previousSection: -> 
      @set("section", @get("section")-1) unless @get("section") is @get("sections.firstObject.number")