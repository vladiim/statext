(function() {
  var IDENTIFYER = '#dashboard';
  var REPORTS_ID = '#reports';
  var LOADING_REPORTS = '#loading-reports';

  RenderReports = {
    init: function() {
      if (this.dashboardPage()) {
        this.render();
      }
    },
    dashboardPage: function() {
      return $(IDENTIFYER).length > 0;
    },
    render: function() {
      $.get('/reports', function(data) {
        R.map(RenderReports.renderReport, data);
      });
      this.deleteLoader();
    },
    // reportData: function() {
    //   $.get('/reports', function(data) {
    //     return data;
    //   });
    // },
    deleteLoader: function() {
      $(LOADING_REPORTS).remove();
    },
    renderReport: function(report) {
      $(REPORTS_ID)
        .append(
          '<div class="col-xs-4">' +
          '<div class="panel panel-primary">' +
          '<div class="panel-heading">' +
          '<div class="panel-title">' +
          report.name +
          '</div></div>' +
          '<div class="panel-body">' +
          '<ul>' +
          '<li><b>Nick name:</b> ' + report.nick_name + '</li>' +
          '<li><b>Web property:</b> ' + report.property + '</li>' +
          '<li><b>Site:</b> ' + report.site + '</li>' +
          '</ul>' +
          '<a class="btn btn-default">Edit</a>' +
          '</div></div></div>'
        )
    }
  }

  $(document).ready(function() {
    RenderReports.init();
  })
})();

// (function() {
//   var GA_PROFILE_MANAGER = '#google-analytics-profile-manager';
//   var SelectForm = {
//     init: function() {
//       if (this.hasGAProfileManager()) {
//         this.buildForm();
//       }
//     },
//     hasGAProfileManager: function() {
//       return $(GA_PROFILE_MANAGER).length > 0;
//     },
//     buildForm: function() {
//       R.map(this.addOption, this.getGAProfiles());
//     },
//     getGAProfiles: function() {
//       return [{
//         name: 'PROFILE NAME',
//         id: 'PROFILE ID',
//         web_property: 'WEB PROPERTY',
//         account: 'ACCOUNT NAME'
//       }]
//     },
//     addOption: function(profile) {
//       $(GA_PROFILE_MANAGER)
//         .find('select.form-control')
//         .append(
//           '<option data-id="' +
//           profile.id + '">' +
//           profile.name + ' > ' +
//           profile.web_property + ' > ' +
//           profile.account +
//           '</option>'
//         )
//     }
//   }
//   $(document).ready(function() {
//     SelectForm.init();
//   });
// })();
