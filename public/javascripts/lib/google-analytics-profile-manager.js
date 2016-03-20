(function() {
  var GA_PROFILE_MANAGER = '#google-analytics-profile-manager';
  var SelectForm = {
    init: function() {
      if (this.hasGAProfileManager()) {
        this.buildForm();
      }
    },
    hasGAProfileManager: function() {
      return $(GA_PROFILE_MANAGER).length > 0;
    },
    buildForm: function() {
      R.map(this.addOption, this.getGAProfiles());
    },
    getGAProfiles: function() {
      return [{
        name: 'PROFILE NAME',
        id: 'PROFILE ID',
        web_property: 'WEB PROPERTY',
        account: 'ACCOUNT NAME'
      }]
    },
    addOption: function(profile) {
      $(GA_PROFILE_MANAGER)
        .find('select.form-control')
        .append(
          '<option data-id="' +
          profile.id + '">' +
          profile.name + ' > ' +
          profile.web_property + ' > ' +
          profile.account +
          '</option>'
        )
    }
  }
  $(document).ready(function() {
    SelectForm.init();
  });
})();
