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
 fs = require('fs')
 xml2js = require('xml2js')
 parser = new xml2js.Parser()
 XmlWriter = require('simple-xml-writer').XmlWriter
 XMLWriter = require('xml-writer')
 XMLPath = 'DATA.xml'
 
 
 robot.respond /Create (.*) with name1 (.*)/i, (res) ->
    itemType = res.match[1]
    itemName = res.match[2]
      
    loadXMLDoc = (filePath) ->
        json = undefined
        try
            fileData = fs.readFileSync(filePath, 'ascii')
            parser = new (xml2js.Parser)
            parser.parseString fileData.substring(0, fileData.length), (err, result) ->
                    json = JSON.stringify(result)
                    console.log JSON.stringify(result)
                    return
            console.log 'File \'' + filePath + '/ was successfully read.\n'
            return json
        catch ex
            console.log ex
        return
    rawJSON = loadXMLDoc(XMLPath)
    obj = 
        containerType: itemType
        containerName: itemName
        
    builder = new (xml2js.Builder)
    xml = builder.buildObject(obj)
    res.reply "#{itemType} is created with name #{itemName}"
        