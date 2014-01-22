describe "App.AppQuestionerComponent", ->
  beforeEach (done) ->
    T.entry_id = JSON.parse(entry_json).entry.id
    T.server.respondWith("GET", "/entries/#{T.entry_id}", [200, {"Content-Type": "application/json"}, entry_json])
    Em.run ->
      T.store.find("entry", T.entry_id).then(
        (res) -> 
          T.entry = res
          done()
        )
        
  # it "sets up Responses on insert", -> true
    
  describe "sections", ->
    it "changes selected section when section changes", ->
      Em.run ->
        T.entry.set("section", 1)
        T.questioner = App.AppQuestionerComponent.create
          # controller: lookupController("entry")
          entry: T.entry
          
        T.questioner.send("setSection",2)
        expect(T.questioner.get("section")).to.eql 2
        expect(T.questioner.get("sections")[1].selected).to.be.true