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
 
    var body = document.querySelector("body");    
    body.style.margin = 0;
    body.style.display = "flex";
    body.style.flexDirection = "column";
    body.style.flexGrow = 1;

    var line0 = addLine(body, "#4267b2", "42px");
    line0.style.height = "42px";
    line0.style.alignItems = "center";
    var space = addColumn(line0, "white","214px");
    var logo = addLine(line0, "#4267b2");
    var logo_left = addLine(logo, "white","23px");
    var logo_right = addLine(logo, "white");
    logo_right.style.width = "393px";
    logo_right.style.marginLeft = "10px";

    //line0.style.justifyContent = "center";
    var logo_img = document.createElement("img");
    logo_img.style.height = "23px";
    logo_img.style.width = "23px";
    logo_img.src = "fb_logo.png";
    logo_left.appendChild(logo_img);


    var line1 = addLine(body, "white");
    var col_left = addColumn(line1, "white","25%");
    col_left.style.borderRight = "1px solid rgba(0, 0, 0, .10)";
    friend_list_top = addLine(col_left,"white", "50px");
    friend_list_top.style.borderBottom = "1px solid rgba(0, 0, 0, .10)";
    roue_container = addColumn(friend_list_top, "white", "50px");

    roue_container.style.alignItems = "center";
    roue_container.style.justifyContent = "center";
    var roue_img = document.createElement("img");
    roue_img.style.height = "23px";
    roue_img.style.width = "23px";
    roue_img.src = "roue.png";
    roue_container.appendChild(roue_img);

    msg_text = addColumn(friend_list_top, "white");
    msg_text.style.color = "#1d2129";
    msg_text.style.textAlign = "center";
    msg_text.style.verticalAlign = "center";
    msg_text.appendChild(document.createTextNode("Messenger"));
    msg_text.style.fontSize = "16px";
    msg_text.style.fontWeight = "500";
    msg_text.style.webkitFontSmoothing = "antialiased";
    msg_text.style.fontFamily = "system-ui, -apple-system, BlinkMacSystemFont, '.SFNSText-Regular', sans-serif";
    msg_text.style.lineHeight = "50px";


    pen_container = addColumn(friend_list_top, "white", "50px");
    pen_container.style.alignItems = "center";
    pen_container.style.justifyContent = "center";
    var pen_img = document.createElement("img");
    pen_img.style.height = "23px";
    pen_img.style.width = "23px";
    pen_img.src = "pen.png";
    pen_container.appendChild(pen_img);


    var col_right = addColumn(line1, "white");
    var top_info = addLine(col_right, "white", "50px");
    top_info.style.borderBottom = "1px solid rgba(0, 0, 0, .10)";
    var content = addLine(col_right, "white");
    var chat_box = addColumn(content, "white");
    chat_box.style.borderRight = "1px solid rgba(0, 0, 0, .10)";
    var chat_content = addLine(chat_box, "white");
    chat_content.style.borderBottom = "1px solid rgba(0, 0, 0, .10)";
    var chat_input = addLine(chat_box, "white","50px");
    var info_box = addColumn(content, "white","33%");
    var info_box_top = addLine(info_box, "white","80px");
    info_box_top.style.borderBottom = "1px solid rgba(0, 0, 0, .10)";
    var info_box_middle = addLine(info_box, "white");
    var info_box_bottom = addLine(info_box, "white");
    info_box_bottom.style.borderTop = "1px solid rgba(0, 0, 0, .10)";
    var info_box_bottom_bottom = addLine(info_box, "white","50px");
}

window.onload = function () {
    init();
}
