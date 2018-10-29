function addLine(element, color, height = undefined){
    var line = document.createElement("div");
    line.style.display = "flex";
    line.style.flexDirection = "row";
    line.style.backgroundColor = color;
    if (height == undefined){
	line.style.flexGrow = 1
    } else {
	line.style.height = height
    }
    element.appendChild(line);
    return line;
}

function addColumn(element, color, width = undefined){
    var col = document.createElement("div");
    col.style.backgroundColor = color;
    col.style.display = "flex";
    col.style.flexDirection = "column";
    if (width == undefined){
	col.style.flexGrow = 1
    } else {
	col.style.width = width;
    }
    element.appendChild(col);
    return col;
}

function init() {
    var html = document.querySelector("html");
    html.style.backgroundColor = "lightgrey";
}

window.onload = function () {
    init();
}
