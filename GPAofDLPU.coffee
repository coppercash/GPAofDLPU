###
#  Created by William on 2/23/14.
###

###
# Copy and paste the script in comment into your console of browser.
  (function loadScript(){
    var script = document.createElement("script")
    script.type = "text/javascript";
    script.src = 'https://raw.github.com/coppercash/GPAofDLPU/master/GPAofDLPU.js';
    document.getElementsByTagName("head")[0].appendChild(script);
    window.alert('GPAofDLPU is being loading. It costs less than 1 min.')
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
  json = JSON.stringify courses
  console.log json


class Course

  constructor: (row) ->
    cells = row.children
    for index in [0...cells.length]
      cell = cells[index]
      switch index
        when 0 then this.semester = cell.textContent.trim()
        when 1 then this.id = cell.textContent.trim()
        when 2 then this.name = cell.textContent.trim()
        when 3 then this.type = cell.textContent.trim()
        when 4 then this.period = cell.textContent.trim()
        when 5 then this.credit = cell.textContent.trim()
        when 6 then this.category = cell.textContent.trim()
        when 7 then this.grade = cell.textContent.trim()
        when 8 then this.isDegree = (cell.textContent.trim() is '是')


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



class ReportCard

  @getReportCards: (document) ->
    allTables = document.getElementsByTagName('table')
    table for table in allTables when this.isTableAReportCard(table)

  @isTableAReportCard: (table) ->
    bordercolor = table.attributes['bordercolor']
    bordercolor and bordercolor.value is '#000000'


runOnLoad()