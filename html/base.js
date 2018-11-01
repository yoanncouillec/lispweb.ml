function Flex(){

    Node.prototype.add = Node.prototype.appendChild;

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

    this.column = function(justify="center"){
	el = document.createElement("div");
	el.style.border = "inherit";
	el.style.margin = "inherit";
	el.style.padding = "inherit";
	//el.style.boxSizing = "inherit";
	el.style.display = "flex";
	el.style.flexDirection = "column";
	//el.style.width = "100%";
	el.style.justifyContent = justify;
	//el.style.flexGrow = 1;
	return el;
    }

    this.line = function(justify="center"){
	el = document.createElement("div");
	el.style.border = "inherit";
	el.style.margin = "inherit";
	el.style.padding = "inherit";
	//el.style.boxSizing = "inherit";
	el.style.display = "flex";
	el.style.flexDirection = "line";
	//el.style.height = "100%";
	//el.style.flexGrow = 1;
	el.style.justifyContent = justify;
	return el;
    }

    this.input = function(){
	el = document.createElement("input");
	el.style.border = "inherit";
	el.style.margin = "inherit";
	el.style.padding = "inherit";
	el.style.color = "inherit";
	el.style.backgroundColor = "inherit";
	el.style.fontFamily = "inherit";
	el.style.fontSize = "inherit";
	el.style.letterSpacing = "inherit";
	return el;
    }

}

function createCORSRequest(method, url) {
    var xhr = new XMLHttpRequest();
    if ("withCredentials" in xhr) {
	// XHR for Chrome/Firefox/Opera/Safari.
	xhr.open(method, url, true);
    } else if (typeof XDomainRequest != "undefined") {
	// XDomainRequest for IE.
	xhr = new XDomainRequest();
	xhr.open(method, url);
    } else {
	// CORS not supported.
	xhr = null;
    }
    return xhr;
}

function makeCorsRequest(method, url) {
}

function init2(){
    flex = new Flex();
    flex.debug(true);
    body = flex.body();

    header = flex.line();
    //header.style.height = "50px";
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
    middle.style.backgroundColor = "black";
    middle.style.color = "white";
    middle.style.justifyContent = "left";
    content.appendChild(middle);

    prompt_entry = flex.column();
    prompt_entry.style.fontFamily = "'Courier New', Courier, monospace";
    prompt_entry.style.fontSize = "16px";
    //prompt_entry.style.letterSpacing = "1px";
    middle.appendChild(prompt_entry);
    prompt_input = flex.line("left");    
    prompt_entry.add(prompt_input);
    prompt_welcome = flex.column();
    prompt_welcome.add(document.createTextNode(">"));
    prompt_input.add(prompt_welcome);
    prompt_user_input = flex.input();
    prompt_user_input.style.width = "100%";
    prompt_user_input.addEventListener("keypress", function(event){
	if (event.code == "Enter"){
	    var url = 'http://localhost:8765';
	    var method = "POST";
	    var xhr = new XMLHttpRequest();
	    xhr.open(method, url);
	    xhr.onload = function() {
		var text = xhr.responseText;
		console.log(text);
	    };
	    
	    xhr.onerror = function() {
		alert('Woops, there was an error making the request.');
	    };
	    
	    xhr.setRequestHeader("Content-Type", "application/json");
	    //xhr.setRequestHeader("Origin", "http://localhost:8765");
	    command = {"command":this.value}
	    xhr.send(JSON.stringify(command));
	}
    });
    prompt_input.add(prompt_user_input);
    prompt_response = flex.line();
    prompt_entry.add(prompt_response);


    right = flex.column();
    right.style.width = "20%";
    content.appendChild(right);

    footer = flex.line();
    footer.style.height = "10px";
    body.appendChild(footer);
}

window.onload = function () {
    init2();
}
