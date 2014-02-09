App.UserController = Ember.ObjectController.extend
  defaultStartDate: moment().subtract(moment.duration({"days": 4})).format("MMM-DD-YYYY")
  defaultEndDate: moment().format("MMM-DD-YYYY")