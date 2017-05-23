/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function asyncUpload(data, id) {
    setTimeout(function() {
        var elements = [data];
        elements = split(elements);
        //test(elements);
        for (var i = 0; i < elements.length; i++) {
            jQuery.ajax({
                type: "POST",
                url: '/assignment/asyncUploadHandler',
                data: {index: i, id: id, element: elements[i]},
                success: function (data) {
                },
                failure: function (data) {
                }
            });
        }
    },0);
}
function test(elements) {
    var buildString = "";
    for (var i = 0; i < elements.length; i++) {
        buildString = buildString + elements[i];
    }
    window.atob(buildString);
}
function subsplit(element) {
    return [element.substring(0,element.length/2),element.substring(element.length/2)];
}
function split(elements) {
    while (elements[0].length > 1000000) {
        var newElements = [];
        for (var i = 0; i < elements.length; i++) {
            newElements = newElements.concat(subsplit(elements[i]));
        }
        elements = newElements.slice();
    }
    return elements;
}