App.AppQuestionerComponent = Ember.Component.extend
  section: 1
  currentGroup: null
  
  questionsBinding: "entry.questions"
  responsesBinding: "entry.responses"
  
  # Insert all possible responses for forms to depend on
  didInsertElement: Em.observer ->
    self = @
    @get("questions").forEach (question) ->
      _uuid = uuid question.get("name"), self.get("entry.id")
      response = self.get("responses").findBy("id", _uuid )
      if response
        response.set("question", question)
      else
        self.get("responses").createRecord({id: _uuid , name: question.get("name"), value: null, question: question})
  .observes("entry.isLoaded")
    
  # responseForQuestion: (question) ->
  #   debugger
  #   @get("responses").findBy("uuid", "#{question.get('name')}_#{@get("entry.id")}")
  
  sectionResponses: Em.computed ->
    names = @get("questions").filterBy("section", @get("section")).mapBy("name")
    @get("responses").filter (response) -> names.contains(response.get("name"))
    
  .property("questions.section", "section", "responses.@each")
  
  sections: Em.computed ->
    self = @
    @get("questions").mapBy("section").uniq().sort().map (section) -> 
      {number: section, selected: section is self.get("section")}
  .property("questions.section", "section")
  
  bla: -> debugger
  # click: -> debugger
  
  actions:
    setResponse: (response, value) -> 
      response.set("value", value)
      @send("nextSection") if @get("sectionResponses.length") == 1
      @sendAction()
      
    setSection: (section) -> @set("section", section)
    nextSection: -> @set("section", @get("section")+1) unless @get("section") is @get("sections.lastObject")
    previousSection: -> @set("section", @get("section")-1) unless @get("section") is @get("sections.firstObject")