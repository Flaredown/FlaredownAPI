# describe "App.LoginRoute", ->
#   controller = undefined
#   route = undefined
#   beforeEach ->
#     controller = createSpyObj("controller", ["set"])
#     route = App.LoginRoute.create()
#     spyOn(route, "controllerFor").and.returnValue controller
# 
#   it "calls controllerFor with application", ->
#     route.activate()
#     expect(route.controllerFor).toHaveBeenCalledWith "application"
# 
#   it "sets loginLayout on applicationController on activate", ->
#     route.activate()
#     expect(controller.set).toHaveBeenCalledWith "loginLayout", true
# 
#   it "unsets loginLayout on applicationController on deactivate", ->
#     route.deactivate()
#     expect(controller.set).toHaveBeenCalledWith "loginLayout", false
# 
