describe "App.Entry", ->
  beforeEach ->
    Em.run ->
      T.entry = T.store.createRecord("entry", {date: "2014-01-22"})
      Em.run ->
        Em.A([{id: 1, name: "foo", value: 1}, {id: 2, name: "bar", value: null}]).forEach (response) ->
          T.entry.get("responses").createRecord(response)
      
  it "#entryDate returns in format Jan-1-2020", ->
    expect(T.entry.get("entryDate")).to.eql "Jan-22-2014"
    
  it "#entryDateParam returns 'today' if it's today", ->
    Em.run ->
      T.entry.set("date", moment().format())
    expect(T.entry.get("entryDateParam")).to.eql "today"
  
  describe "#responsesData", ->
    it "returns strips null value responses", ->
      Em.run -> expect(T.entry.get("responsesData.length")).to.eql 1
      
    it "returns formatted responses array", ->
      expect(T.entry.get("responsesData.firstObject.name")).to.eql "foo"
      expect(T.entry.get("responsesData.firstObject.value")).to.eql 1