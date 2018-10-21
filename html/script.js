window.onload = function() {
    var content = document.getElementById("content");
    var terminal = content.querySelector("code.terminal");
    var active = terminal.querySelector("span.active");
    active.focus();
    
    active.addEventListener('keydown', (event) => {
	const keyname = event.key;
	
	if (keyname === 'Control') {
	    // Pas d'alerte si seule la touche Control est pressée.
	    return;
	}
	if (keyname == "Enter") {
	    alert("Enter");
	    var msg = active.val().replace(/\n/g, "");
	    return false;
	}
	
	if (event.ctrlKey) {
	    // Ctrl + key
	    alert(`ctrl + ${keyname}`);
	} else {
	    // One key
	}
    }, false);
}
