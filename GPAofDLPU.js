// Generated by CoffeeScript 1.7.1

/*
 *  Created by William on 2/23/14.
 */


/*
 * Copy and paste the script in comment into your console of browser.
  (function loadScript(){
    var script = document.createElement("script")
    script.type = "text/javascript";
    script.src = 'https://raw.github.com/coppercash/GPAofDLPU/master/GPAofDLPU.js';
    document.getElementsByTagName("head")[0].appendChild(script);
    window.alert('GPAofDLPU is being loading. It costs less than 1 min.')
  })();
 */


/*
  {"version":"95ed3d84-6d7d-4e49-b9db-db27d16ec322",
  "courses":[
  {
  "selected":true,
  "name":"健康教育",
  "credit":1,
  "grade":"99",
  "groups":"非学位课"
  }]}
 */

(function() {
  var Course, ReportCard, runOnLoad;

  runOnLoad = function() {
    var courses, json, row, rows, table, _i, _j, _len, _len1, _ref, _ref1;
    window.alert('GPAofDLPU is loaded and installed well.');
    rows = new Array();
    _ref = ReportCard.getReportCards(document);
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      table = _ref[_i];
      _ref1 = table.children[0].children;
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        row = _ref1[_j];
        rows.push(row);
      }
    }
    courses = (function() {
      var _k, _len2, _results;
      _results = [];
      for (_k = 0, _len2 = rows.length; _k < _len2; _k++) {
        row = rows[_k];
        if (Course.isRowACourse(row)) {
          _results.push(new Course(row));
        }
      }
      return _results;
    })();
    json = JSON.stringify({
      'version': '95ed3d84-6d7d-4e49-b9db-db27d16ec322',
      'courses': courses
    });
    return console.log(json);
  };

  Course = (function() {
    function Course(row) {
      var attrMap, cells, converter, index, text, _i, _ref;
      cells = row.children;
      for (index = _i = 0, _ref = cells.length; 0 <= _ref ? _i < _ref : _i > _ref; index = 0 <= _ref ? ++_i : --_i) {
        text = cells[index].textContent.trim();
        attrMap = [
          {
            'attr': 'semester'
          }, {
            'attr': 'id'
          }, {
            'attr': 'name'
          }, {
            'attr': 'type'
          }, {
            'attr': 'period'
          }, {
            'attr': 'credit',
            'cvt': Course.convertCredit
          }, {
            'attr': 'category'
          }, {
            'attr': 'grade',
            'cvt': Course.convertGrade
          }, {
            'attr': 'isDegree',
            'cvt': Course.convertIsDegree
          }
        ][index];
        converter = attrMap['cvt'];
        this[attrMap['attr']] = typeof converter === 'function' ? converter(text) : text;
      }
    }

    Course.isRowACourse = function(row) {
      var idCell, text;
      idCell = row.children[1];
      text = idCell.textContent.trim();
      return text >>> 0 === parseFloat(text);
    };

    Course.prototype.toJSON = function() {
      return {
        'selected': true,
        'name': this.name,
        'credit': this.credit,
        'grade': this.grade,
        'groups': (this.isDegree ? '学' : '非')
      };
    };

    Course.convertCredit = function(text) {
      return parseInt(text);
    };

    Course.convertIsDegree = function(text) {
      return text === '是';
    };

    Course.convertGrade = function(text) {
      var grade;
      grade = {
        '优': 95,
        '良': 85,
        '中': 75,
        '及格': 65,
        '合格': 65
      }[text];
      if (grade !== void 0) {
        return grade;
      } else {
        return parseInt(text);
      }
    };

    return Course;

  })();

  ReportCard = (function() {
    function ReportCard() {}

    ReportCard.getReportCards = function(document) {
      var allTables, table, _i, _len, _results;
      allTables = document.getElementsByTagName('table');
      _results = [];
      for (_i = 0, _len = allTables.length; _i < _len; _i++) {
        table = allTables[_i];
        if (this.isTableAReportCard(table)) {
          _results.push(table);
        }
      }
      return _results;
    };

    ReportCard.isTableAReportCard = function(table) {
      var borderColor;
      borderColor = table.attributes['bordercolor'];
      return borderColor && borderColor.value === '#000000';
    };

    return ReportCard;

  })();

  runOnLoad();

}).call(this);

//# sourceMappingURL=GPAofDLPU.map
