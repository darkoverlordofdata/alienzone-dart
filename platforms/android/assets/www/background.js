chrome.app.runtime.onLaunched.addListener(function() {
    chrome.app.window.create('index.html', {
        'id': 'd16a',
        'outerBounds': {
            'width': 512,
            'height': 768
        }
    });
});