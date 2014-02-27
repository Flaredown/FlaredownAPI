App.UserController = Ember.ObjectController.extend
  defaultStartDate: moment().subtract(moment.duration({"days": 20})).format("MMM-DD-YYYY")
  defaultEndDate: moment().format("MMM-DD-YYYY")