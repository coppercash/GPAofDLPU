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

class Course


runOnLoad = ->
  window.alert 'GPAofDLPU is loaded and installed well.'


getReportTable = ->
  return document.getElementsByClassName('tableborder')


tableToCourses = (table) ->
  rowToCourse(row) for row in table when isRowACourse(row)


isRowACourse = (row) ->
  true


rowToCourse = (row) ->

  course = new Course

  for index in [0...row.length]

    cell = row[index]

    switch index
      when 0 then course.semester = cell.text
      when 1 then course.id = cell.text
      when 2 then course.name = cell.text
      when 3 then course.type = cell.text
      when 4 then course.period = cell.text
      when 5 then course.credit = cell.text
      when 6 then course.category = cell.text
      when 7 then course.grade = cell.text
      when 8 then course.isDegree = cell.text

  course
