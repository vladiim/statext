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
