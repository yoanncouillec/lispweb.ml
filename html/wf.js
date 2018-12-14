function load(){
    TweenLite.set("#circle", {transformOrigin:"50% 50%"})
    
    Draggable.create("#box", {
	type:"x,y",
	bounds:"#container",
	overshootTolerance:0,
	throwProps:true
    })
    
    Draggable.create("#circle", {
	type:"rotation",
	throwProps:true
    })


    //body = document.querySelector("body");    

    // n0 = document.createElement("div");
    // n0.style.width = "100px"
    // n0.style.height = "100px"
    // n0.style.backgroundColor = "black"
    // n0.style.left = "10px"
    // n0.style.top = "10px"
    // $(n0).draggable();
    // body.appendChild(n0)

    // var ns = 'http://www.w3.org/2000/svg'
    // var div = document.getElementById('drawing') 
    // var svg = document.createElementNS(ns, 'svg')
    // svg.setAttributeNS(null, 'width', '100%')
    // svg.setAttributeNS(null, 'height', '100%')
    // div.appendChild(svg)

    // var rect = document.createElementNS(ns, 'rect')
    // rect.setAttributeNS(null, 'width', 100)
    // rect.setAttributeNS(null, 'height', 100)
    // rect.setAttributeNS(null, 'fill', '#f06')
    
    // svg.appendChild(rect)
    
}

window.onload = function () {
    load()
}
