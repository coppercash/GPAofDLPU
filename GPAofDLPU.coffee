###
#  Created by William on 2/23/14.
###

###
# Copy and paste the script in comment into your console of browser.
  (function loadScript(){
    var script = document.createElement("script")
    script.type = "text/javascript";
    script.src = 'https://raw.github.com/coppercash/GPAofDLPU/master/GPAofDLPU.js';
    script.onload = function(){ runOnLoad(); };
    document.getElementsByTagName("head")[0].appendChild(script);
    window.alert('GPAofDLPU is being loading. It costs less than 1 min.')
  })();
###



runOnLoad = ->
  window.alert 'GPAofDLPU is loaded and installed well.'

  tableElement = getReportTable()
  courses =  new Course row for row in tableElement when Course.isRowACourse(row)
  json = JSON.stringify(courses)
  console.log(json)


getReportTable = ->
  return document.getElementsByClassName('tableborder')


class Course

  constructor: (row) ->

    for index in [0...row.length]

      cell = row[index]

      switch index
        when 0 then this.semester = cell.text
        when 1 then this.id = cell.text
        when 2 then this.name = cell.text
        when 3 then this.type = cell.text
        when 4 then this.period = cell.text
        when 5 then this.credit = cell.text
        when 6 then this.category = cell.text
        when 7 then this.grade = cell.text
        when 8 then this.isDegree = cell.text

  @isRowACourse: (row) ->
    true

  toJSON: () ->
    {
    'a': this.semester,
    'a': this.id,
    'a': this.name,
    'a': this.type,
    'a': this.period,
    'a': this.credit,
    'a': this.category,
    'a': this.grade,
    'a': this.isDegree,
    }
