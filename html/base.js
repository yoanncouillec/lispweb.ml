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

function makeFlexContainer(element, orientation = "line", size = undefined){
    element.style.border = "inherit";
    element.style.display = "flex";
    element.style.flexDirection = orientation;
    if (orientation == "line"){
	if (size == undefined){
	    element.style.flexGrow = 1
	} else {
	    element.style.height = size;
	}
    } else if (orientation == "column"){
	if (size == undefined){
	    element.style.flexGrow = 1
	} else {
	    element.style.width = size;
	}
    } else {
	throw "unknown orientation " + orientation;
    }
    return element;
}

function Flex(){

    h = document.querySelector("html");    
    h.style.display = "flex";
    h.style.flexDirection = "column";
    h.style.fontFamily = "'Lato', sans-serif";
    h.style.fontSize = "16px";
    h.style.fontWeight = "300";
    h.style.height = "100vh";
    h.style.boxSizing = "border-box";
    h.style.border = "none";
    h.style.margin = 0;
    h.style.padding = 0;

    b = document.querySelector("body");    
    b.style.display = "flex";
    b.style.flexDirection = "column";
    b.style.fontFamily = "'Lato', sans-serif";
    b.style.fontSize = "16px";
    b.style.fontWeight = "300";
    b.style.height = "100vh";
    b.style.boxSizing = "border-box";
    b.style.border = "none";
    b.style.margin = 0;
    b.style.padding = 0;

    this.debug = function(d){
	b = document.querySelector("body");    
	if (d){
	    b.style.border = "dashed red 3px";
	    b.style.margin = "10px";
	    b.style.padding = "10px";
	} else {
	    b.style.border = "none";
	    b.style.margin = 0;
	    b.style.padding = 0;
	}
    }

    this.body = function(){
	el = document.querySelector("body");    
	return el;
    }

    this.column = function(){
	el = document.createElement("div");
	el.style.border = "inherit";
	el.style.margin = "inherit";
	el.style.padding = "inherit";
	//el.style.boxSizing = "inherit";
	el.style.display = "flex";
	el.style.flexDirection = "column";
	//el.style.width = "100%";
	el.style.justifyContent = "center";
	//el.style.flexGrow = 1;
	return el;
    }

    this.line = function(){
	el = document.createElement("div");
	el.style.border = "inherit";
	el.style.margin = "inherit";
	el.style.padding = "inherit";
	//el.style.boxSizing = "inherit";
	el.style.display = "flex";
	el.style.flexDirection = "line";
	//el.style.height = "100%";
	//el.style.flexGrow = 1;
	el.style.justifyContent = "center";
	return el;
    }

}

function init2(){
    flex = new Flex();
    flex.debug(true);
    body = flex.body();

    header = flex.line();
    header.style.height = "50px";
    body.appendChild(header);

    title = flex.column();
    title.style.fontSize = "54px";
    title.appendChild(document.createTextNode("Title"));
    header.appendChild(title);

    content = flex.line();
    //content.style.height = "";
    content.style.flexGrow = 1;
    body.appendChild(content);

    menu = flex.column();
    menu.style.width = "20%";
    content.appendChild(menu);

    middle = flex.column();
    middle.style.width = "100%";
    content.appendChild(middle);

    //par0 = flex.column();
    //par0.appendChild(document.createTextNode("text text text text text text text"));
    //middle.appendChild(par0);

    right = flex.column();
    right.style.width = "20%";
    content.appendChild(right);

    footer = flex.line();
    footer.style.height = "10px";
    body.appendChild(footer);
}

function init() {

    // BODY
    var body = document.querySelector("body");    
    body.style.margin = "10px";
    //body.style.margin = 0;
    body.style.padding = "10px";
    //body.style.padding = 0;
    //body = makeFlexContainer(body, "column");
    body.style.border = "inherit";
    body.style.display = "flex";
    body.style.flexDirection = "column";
    body.style.backgroundColor = "white";
    body.style.border = "dashed red 3px";
    body.style.fontFamily = "'Lato', sans-serif";
    body.style.fontSize = "16px";
    body.style.fontWeight = "300";

    // HEADER
    header = document.createElement("div");
    //header = makeFlexContainer(header, "line", "20%");
    //header.style.minHeight = "60px";
    //header.style.maxHeight = "100px";
    header.style.fontSize = "54px";
    //header.style.alignItems = "center";
    header.style.justifyContent = "center";
    header.style.border = "inherit";
    header.style.margin = "inherit";
    header.style.padding = "inherit";
    header.style.display = "flex";
    header.style.flexDirection = "line";
    header.style.flexGrow = 1
    header.style.lineHeight = "58px";
    //header.style.height = "30px";
    body.appendChild(header);

    // TITLE
    header_title = document.createElement("div");
    header_title.style.border = "inherit";
    header_title.style.margin = "inherit";
    header_title.style.padding = "inherit";
    header_title.appendChild(document.createTextNode("Title"));
    header_title.style.fontSize = "54px";
    header.appendChild(header_title);

    // CONTENT
    content = document.createElement("div");
    //content = makeFlexContainer(content, "line", "20%");
    //content.style.alignItems = "center";
    content.style.justifyContent = "center";
    content.style.border = "inherit";
    content.style.margin = "inherit";
    content.style.padding = "inherit";
    content.style.display = "flex";
    content.style.flexDirection = "line";
    content.style.flexGrow = 1;
    body.appendChild(content);

    // MENU
    x0_container = document.createElement("div");
    x0_container.style.display = "flex";
    x0_container.style.flexDirection = "column";
    x0_container.style.justifyContent = "center";
    x0_container.style.width = "50%";
    x0_container.style.border = "inherit";
    x0_container.style.margin = "inherit";
    x0_container.style.padding = "inherit";

    x0 = document.createElement("div");
    //x0 = makeFlexContainer(x0, "line", "20%");
    //x0.style.alignItems = "center";
    //x0.style.justifyContent = "center";
    x0.style.border = "inherit";
    x0.style.margin = "inherit";
    x0.style.padding = "inherit";
    //x0.style.display = "inline-block";
    //x0.style.flexDirection = "line";
    //x0.style.flexGrow = 1;
    //x0.style.flexShrink = 1;
    x0.style.lineHeight = "20px";
    x0.style.textAlign = "center";

    x0_container.appendChild(x0);

    content.appendChild(x0_container);

    x0.appendChild(document.createTextNode("Tiled say decay spoil now walls meant house. My mr interest thoughts screened of outweigh removing. Evening society musical besides inhabit ye my. Lose hill well up will he over on. Increasing sufficient everything men him admiration unpleasing sex. Around really his use uneasy longer him man. His our pulled nature elinor talked now for excuse result. Admitted add peculiar get joy doubtful."));

    // MIDDLE
    x1 = document.createElement("div");
    //x1 = makeFlexContainer(x1, "line", "21%");
    x1.style.alignItems = "center";
    x1.style.justifyContent = "center";
    x1.style.border = "inherit";
    x1.style.margin = "inherit";
    x1.style.padding = "inherit";
    //x1.style.display = "inline-block";
    x1.style.flexDirection = "line";
    //x1.style.flexGrow = 1;
    //x1.style.flexShrink = 1;
    x1.style.width = "100%";
    content.appendChild(x1);

    // RIGHT
    x2 = document.createElement("div");
    //x2 = makeFlexContainer(x2, "line", "21%");
    x2.style.alignItems = "center";
    x2.style.justifyContent = "center";
    x2.style.border = "inherit";
    x2.style.margin = "inherit";
    x2.style.padding = "inherit";
    //x2.style.display = "inline-block";
    x2.style.flexDirection = "line";
    //x2.style.flexGrow = 1;
    //x2.style.flexShrink = 1;
    x2.style.width = "20%";
    content.appendChild(x2);

    // FOOTER
    footer = document.createElement("div");
    //footer = makeFlexContainer(footer, "line", "10%");
    //footer.style.minHeight = "30px";
    //footer.style.maxHeight = "50px";
    footer.style.fontSize = "24px";
    footer.style.alignItems = "center";
    footer.style.justifyContent = "center";
    footer.style.border = "inherit";
    footer.style.margin = "inherit";
    footer.style.padding = "inherit";
    footer.style.display = "flex";
    footer.style.flexDirection = "line";
    footer.style.flexGrow = 1
    //footer.style.height = "30px";
    body.appendChild(footer);

    // // P0
    // p0 = document.createElement("div");
    // //p0.appendChild(document.createTextNode("text text texttext text text"));
    // p0.style.border = "inherit";
    // p0.style.margin = "inherit";
    // p0.style.padding = "inherit";
    // p0.style.flexGrow = 1
    // //p0.style.display = "flex";
    // content.appendChild(p0);

    // // P1
    // p1 = document.createElement("div");
    // //p1.appendChild(document.createTextNode("text text text"));
    // p1.style.border = "inherit";
    // p1.style.margin = "inherit";
    // p1.style.padding = "inherit";
    // p1.style.flexGrow = 1
    // //p1.style.display = "flex";
    // content.appendChild(p1);


    // title = document.createElement("div");
    // title.appendChild(document.createTextNode("Header"));

    // header.appendChild(title);
    
    // content = document.createElement("div");
    // content.style.color = "white";
    // content = makeFlexContainer(content, "line");
    // content.style.flexDirection = "line";

    // body.appendChild(content);

    // footer = document.createElement("div");
    // footer = makeFlexContainer(footer, "line", "10%");
    // footer.style.minHeight = "30px";
    // footer.style.maxHeight = "50px";
    // footer.style.backgroundColor = "white";
    // footer.style.alignItems = "center";
    // footer.style.justifyContent = "center";

    // body.appendChild(footer);

    // footer_text = document.createElement("div");
    // footer_text.appendChild(document.createTextNode("Footer"));
    // footer_text.style.fontSize = "20px";

    // footer.appendChild(footer_text);

    // p2 = document.createElement("div");
    // p2.appendChild(document.createTextNode("text text text"));
    // p2.style.display = "flex";
    // content.appendChild(p2);


}

window.onload = function () {
    init2();
}
