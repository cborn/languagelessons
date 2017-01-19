package languagelessons

class TabsaveTagLib {
    static defaultEncodeAs = [taglib:'none']
    //static encodeAsForTags = [tagName: [taglib:'html'], otherTagName: [taglib:'none']]
    
    def tabSave = { 
        out << render (template: '/templates/code/tabsave')
        }
}
