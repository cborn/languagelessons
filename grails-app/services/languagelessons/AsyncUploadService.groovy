package languagelessons

import grails.transaction.Transactional

@Transactional
class AsyncUploadService {
    def uploadsMap = [:]
    def put(String id,int index,String data) {
        if (uploadsMap[id]) {
            uploadsMap[id][index] = data
        } else {
            uploadsMap[id] = [(index): data]
        }
        println(uploadsMap)
    }
    def get(id) {
        println(uploadsMap)
        String res = "";
        int max = uploadsMap[id].max{it.key}.key
        for (int i = 0; i <= max; i++) {
            res = res + uploadsMap[id][i]
        }
        return res
    }
}
