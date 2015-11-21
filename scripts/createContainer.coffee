# CoffeeScript
# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

module.exports = (robot) ->
 xml2js = require('xml2js')
 parser = new xml2js.Parser()
 XMLWriter = require('xml-writer')
 fs = require('fs')
 XMLPath = 'DATA.xml'
 
 robot.hear /badger/i, (res) ->
   res.send "Badgers? BADGERS? WE DON'T NEED NO STINKIN BADGERS"
 
 robot.respond /Create (.*) with name of (.*)/i, (res) ->
    itemType = res.match[1]
    itemName = res.match[2]
#    data = JSON.stringify({
#        containerType: itemType,
#        containerName: itemName
#    })
   
    et = require('elementtree')
    ElementTree = et.ElementTree
    element = et.Element
    subElement = et.SubElement
    presentXML = undefined
    newXml = undefined
    presentXML = fs.readFileSync(XMLPath).toString()
    newXml = et.parse(presentXML)
    container = subElement(newXml._root, 'container')
    container.set 'type', itemType
    container.set 'name', itemName
    etree = new ElementTree(newXml._root)
    xml = etree.write('xml_declaration': true)
    fs.writeFile XMLPath, xml, (err) ->
        if err
            return console.log(err)
        console.log 'The file was saved!'
        return
    
    res.reply "#{itemType} is created with name #{itemName} and #{xml}"
