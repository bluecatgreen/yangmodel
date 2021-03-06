import sys
import getopt
from pyangbind.lib import pybindJSON
import json
import logging
import traceback
from pprint import pformat

topicModelMapping =[ 
        {"topic":"UT_ALARMS_CIENA","mappingFile": "mappings/UT_Ciena_AlarmMapper.json"}
        ]
loadedMaps = []

def getMappingDetails(topic):
    global loadMaps
    global topicModelMapping
    mapDetails = None
    for maps in loadedMaps:
        if maps['topic'] == topic:
            mapDetails = maps
            break
    # it is just return
    if mapDetails != None:
        return mapDetails

    #load mapping file

    #Find configuration we want
    mappingInfo = None
    for topicModel in topicModelMapping:
        if topicModel['topic'] == topic:
            mappingInfo = topicModel
            break

    if mappingInfo == None:
        print ('No mapping found for: ' + topic)
        return None

    # Load mapping file
    mappingObj = loadMappingFile(mappingInfo['mappingFile'])

    mappingDetails = dict()
    mappingDetails['topic'] = topic
    mappingDetails['mappingObj'] = mappingObj

    #Load pythong object first (import)

    try:
        yangObj = __import__(mappingObj['pyangObj'])
    except ImportError as e:
        print(str(e))
        return None
    mappingDetails['yangObj'] = yangObj

    loadedMaps.append(mappingDetails)

    return mappingDetails

def loadMappingFile(file):

    mapperStr = ''
    with open(file,'r') as yp:
        line = yp.readline()
        while line:
            mapperStr = mapperStr + line
            line = yp.readline()

    mapperObj = json.loads(mapperStr)

    return mapperObj

# 
# Convert json string to json object
#
def jsonToPyangObject(mappingDetails, jsonStr):
    loadedObject = pybindJSON.loads(jsonStr, mappingDetails['yangObj'], mappingDetails['mappingObj']['modelName'])
    return loadedObject

def convertToYangObject(mappingDetails, line):
    return jsonToPyangObject(mappingDetails, line)

#
# pull the value from the provided json object
#
def getJsonStringValue(jsonObj,tag):

    value = None

    try:
        tags = tag.split('->')
        currentObj = jsonObj
        for key in tags:
            currentObj = currentObj[key]

        if type(currentObj) == str:
            value = currentObj
        elif type(currentObj) == unicode:
            value = str(currentObj)
        elif type(currentObj) == int:
            value = str(currentObj)
        elif type(currentObj) == float:
            value = str(currentObj)
    except Exception as e:
        print ('Unable to find tag: ('+ tag+ ') Exception: ' + str(e))

    return value

def getJsonDict(jsonObj, tag):
    value = None
    try:
        tags = tag.split('->')
        currentObj = jsonObj
        for key in tags:
            currentObj = currentObj[key]
    except Exception as e:
        print ('Unable to find tag: ('+ tag+ ') Exception: ' + str(e))

    return currentObj


def getJsonIntValue(jsonObj, tag):
    value = None
    try:
        tags = tag.split('->')
        currentObj = jsonObj
        for key in tags:
            currentObj = currentObj[key]

        value = currentObj
    except Exception as e:
        print ('Unable to find tag: ('+ tag+ ') Exception: ' + str(e))

    return value

def getJsonListValue(jsonObj, mapperObj):
    yangDict = dict()
    
    try:
        tags = mapperObj['tag'].split('->')
        currentObj = jsonObj
        for key in tags:
            currentObj = currentObj[key]

        if type(currentObj) != list:
            return None
        for co in currentObj:

            item = dict()
            individual = dict()

            keyTag = mapperObj['keys'][mapperObj['key']]['tag']
            value = getJsonStringValue(co,keyTag)
            item = dict()
            yangDict[value] = item

            for key in mapperObj['keys'].keys():
                keyObj = mapperObj['keys'][key]
                if type(keyObj) == dict:
                    if keyObj['type'] == 'string':
                            item[key] = getJsonStringValue(co,keyObj['tag'])
                    elif keyObj['type'] == 'string-list':
                      value = getJsonDict(jsonOb, tag)
                      item[key] = []
                      for v in values:
                           item[key].append(v)
                    elif keyObj['type'] == int:
                      item[ke] = jgetJsonIntValue(co,keyObj['tag'])
                    elif keyObj['type'] == 'grouping':
                      groupMapper = keyObj['grouping']
                      item[key] = dict()
                      groupJsonObj = getJsonDict(co, keyObj['tag'])
                      convertToYangJsonWithMapping(groupMapper, item[key], groupJsonObj)
    except Exception as e:
        print ('Unable to find tag: (' + mapperObj['tag'] + ') Exception: ' + str(e))
        traceback.print_exc()

    return yangDict

#
# Given the mapper convert this to a yang model object
#

def convertToYangJsonStr(mappingDetails, jsonObj):
    perfdataJsonObj = dict()
    yangJsonObj = dict()
    yangObj = None
    mapperObj = mappingDetails['mappingObj']

    perfdataJsonObj[mapperObj['rootNode']] = yangJsonObj

    #
    # setup the top root
    #

    convertToYangJsonWithMapping(mapperObj,yangJsonObj, jsonObj)
    print ('Original JSON')
    print (json.dumps(jsonObj, indent=4))
    print('Converted to this')
    print (json.dumps(perfdataJsonObj, indent=4))
    yangObj = convertToYangObject(mappingDetails, json.dumps(perfdataJsonObj))
    return json.dumps(yangObj.get())

def convertToYangJsonWithMapping(mapperObj, yangJsonObj, jsonObj):
    
    for key in mapperObj.keys():
        if key == 'modelName':
            continue

        if type(mapperObj[key]) == dict:
            dictObj = mapperObj[key]
            if dictObj['type'] == 'string':
                value = getJsonStringValue(jsonObj, dictObj['tag'])
                yangJsonObj[key] = getJsonStringValue(jsonObj, dictObj['tag'])
            elif dictObj['type'] == 'string-list':
                values = getJsonDict(jsonObj, dictObj['tag'])
                yangJsonObj[key] = []
                for v in values:
                    yangJsonObj[key].append(v)
            elif dictObj['type'] == 'int':
                yangJsonObj[key] = getJsonIntValue(jsonObj,dictObj['tag'])
            elif dictObj['type'] == 'list':
                yangJsonObj[key] = getJsonListValue(jsonObj,dictObj)
            elif dictObj['type'] == 'grouping':
                groupMapper = dictObj['grouping']
                yangJsonObj[key] = dict()
                groupJsonObj = getJsonDict(jsonObj, dictObj['tag'])
                convertToYangJsonWithMapping(groupMapper, yangJsonObj[key], groupJsonObj)
