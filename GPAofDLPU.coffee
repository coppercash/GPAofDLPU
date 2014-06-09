###
#  Created by William on 2/23/14.
###

###
# Copy and paste the script in comment into your console of browser.
  (function loadScript(){
    var script = document.createElement("script");
    script.type = "text/javascript";
    script.language = 'javascript';
    script.charset = 'UTF-8';
    script.src = 'https://raw.github.com/coppercash/GPAofDLPU/master/GPAofDLPU.js';
    script.onload = (function(){runGPA();});
    document.getElementsByTagName("head")[0].appendChild(script);
    window.alert('GPAofDLPU is being loading. It costs less than 1 min.');
  })();
###

###
  {"version":"95ed3d84-6d7d-4e49-b9db-db27d16ec322",
  "courses":[
  {
  "selected":true,
  "name":"健康教育",
  "credit":1,
  "grade":"99",
  "groups":"非学位课"
  }]}
###


runOnLoad = ->
  window.alert 'GPAofDLPU is loaded and installed well.'

  rows = new Array()
  for table in ReportCard.getReportCards(document)
    for row in table.children[0].children
      rows.push row

  courses = ((new Course(row)) for row in rows when Course.isRowACourse(row))
  json = JSON.stringify {'version': '95ed3d84-6d7d-4e49-b9db-db27d16ec322', 'courses': courses}
  console.log json


class Course

  constructor: (row) ->
    cells = row.children
    for index in [0...cells.length]
      text = cells[index].textContent.trim()

      attrMap =
      [
        {'attr': 'semester',}
        {'attr': 'id',}
        {'attr': 'name',}
        {'attr': 'type',}
        {'attr': 'period',}
        {'attr': 'credit', 'cvt': Course.convertCredit}
        {'attr': 'category',}
        {'attr': 'grade', 'cvt': Course.convertGrade}
        {'attr': 'isDegree', 'cvt': Course.convertIsDegree}
      ][index]

      attrKey = attrMap['attr']
      converter = attrMap['cvt']
      this[attrKey] = if converter? then converter(text) else text

  @isRowACourse: (row) ->
    idCell = row.children[1]
    text = idCell.textContent.trim()
    text >>> 0 is parseFloat(text)

  toJSON: () ->
    {
    'selected': true,
    'name': this.name,
    'credit': this.credit,
    'grade': this.grade,
    'groups': (if this.isDegree then '学' else '非'),
    }

  @convertCredit: (text) ->
    parseInt(text)

  @convertIsDegree: (text) ->
    text is '是'

  @convertGrade: (text) ->
    grade = {'优': 95, '良': 85, '中': 75, '及格': 65, '合格': 65,}[text]
    if grade? then grade else parseInt(text)


class ReportCard

  @getReportCards: (document) ->
    allTables = document.getElementsByTagName('table')
    table for table in allTables when this.isTableAReportCard(table)

  @isTableAReportCard: (table) ->
    borderColor = table.attributes['bordercolor']
    borderColor and borderColor.value is '#000000'


window.runGPA = runOnLoad