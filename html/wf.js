function load(){

    var svg = document.querySelector("svg")

    var ns = 'http://www.w3.org/2000/svg'
    var rect = document.createElementNS(ns, 'rect')
    rect.setAttributeNS(null, 'width', 100)
    rect.setAttributeNS(null, 'height', 100)
    rect.setAttributeNS(null, 'rx', 10)
    rect.setAttributeNS(null, 'ry', 10)
    rect.setAttributeNS(null, 'fill', 'red')
    rect.id = "rect"
    svg.appendChild(rect)

    Draggable.create("#rect", {
	type:"x,y",
	bounds:"#svg",
	overshootTolerance:0,
	throwProps:true
    })
}

window.onload = function () {
    load()
}
