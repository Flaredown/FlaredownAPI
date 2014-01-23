T.entry_raw = JSON.parse(entry_json).entry
  
describe "App.EntryController", ->
  beforeEach ->
    T.date = moment(T.entry_raw.date).format("MMM-DD-YYYY")

    T.server.respondWith("GET", "entries/#{T.date}?by_date=true", [200, {"Content-Type": "application/json"}, JSON.stringify({id: T.entry_raw.id})])
    T.server.respondWith("GET", "/entries/#{T.date}?by_date=true", [200, {"Content-Type": "application/json"}, JSON.stringify({id: T.entry_raw.id})])
    T.server.respondWith("GET", "/entries/#{T.entry_raw.id}", [200, {"Content-Type": "application/json"}, entry_json])
  
    visit("/entry/#{T.date}/1")
    Em.run ->
      T.server.respond()
      T.controller = lookupController("entry")
  
  it "loads an entry", ->
    expect(T.controller.get("id")).to.be.a "String"
  
  describe "sections", ->
    it "sets the current section from the URL (route)", ->
      visit("/entry/#{T.date}/2")
      Em.run -> 
        expect(T.controller.get("section")).to.eql 2
        
    it "changes sections#selected when section changes", ->  
      Em.run ->
        T.controller.send("setSection",2)
        expect(T.controller.get("section")).to.eql 2
        expect(T.controller.get("sections")[1].selected).to.be.true
        
    it "changes sections#selected when section changes", ->  
      Em.run ->
        T.controller.send("setSection",2)
        expect(T.controller.get("section")).to.eql 2
        expect(T.controller.get("sections")[1].selected).to.be.true
    
    describe "#actions", ->    
      describe "#updateResponse", ->
        beforeEach ->
          T.server.respondWith("POST", "/entries/#{T.entry_raw.id}", [200, {"Content-Type": "application/json"}, ""])
          Em.run ->
            T.response = T.controller.get("responses.firstObject")
            T.controller.send("setResponse", T.response, 99)
            Em.run ->
              T.server.respond()
        
        it "sets response value", -> 
          expect(T.response.get("value")).to.eql 99
        it "changes section", -> 
          expect(T.controller.get("section")).to.eql 2
        it "sends updates to server", -> 
          responses = Em.A(T.server.responses).filter (res) -> res.method is "POST" and res.url is "/entries/#{T.entry_raw.id}"
          expect(responses).to.have.length 1