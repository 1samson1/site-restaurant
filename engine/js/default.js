$(function(){     
    tinymce.init({
        selector: 'textarea',
        language:"ru",
        mode : "textareas",
        plugins:"link, image, paste",
        statusbar:false,
        menubar:false,
        branding: false,  
        paste_as_text:true,  
        toolbar1: "bold italic underline strikethrough | alignleft aligncenter alignright alignjustify | link image",
    });
});

function send(url, body, method='GET') {
    return fetch(url, {
        method,
        body
    })
    .then(response => response.json())
    .then(json => new Promise((resolve, reject) => {
        if(json.errors){
            return reject(json.errors[0])
        }
        return resolve(json.response)
    }))
    .catch( error => console.error(error))
}
