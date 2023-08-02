const sign = async (name, email, password, repeatPassword) => {
    try{
        const response = fetch(`http://localhost:8080/api/users?name=${name}&email=${email}&password=${password}&repeatPassword=${repeatPassword}`, {
            method: "POST",
        })
        const responseJson = await response.json();
        const data = responseJson.response;
        console.log('data ==>',data)
    } catch(e) {
        console.log('==>', e)
    }
}   
// регистрация 
function SignUp() {
    let name = document.getElementById("form3Example1c").value;
    let email = document.getElementById("form3Example3c").value;
    let password = document.getElementById("form3Example4c").value;
    let repeatPassword = document.getElementById("form3Example4cd").value;
    if (password === repeatPassword ) {
        alert("пользователь" + " " + name + " " + "успешно зарегистрировано!")
        sign(name,email, password, repeatPassword);
        location.href = 'login.html';        
    } else {
        alert("Пароли не совпадают!")
    }  
}

function LogIn() {
    let login = document.getElementById("login").value;
    let password = document.getElementById("password").value;
    console.log("--->",login, password)
    // проверка email в бд что пользователь зарегистрированно или нет ?
     logg(login, password);
}

const logg = async (login, password) => {
    try {
        const resp = await fetch(`http://localhost:8080/api/token?email=${login}&password=${password}`, {
            method: "POST",
        });
        const responseJson = await resp.json();
        token = responseJson.accessToken;
        expire = responseJson.exp
         if (token != "" || expire != 0) {
            auth(token);
        } else if (code === 400) {    
            alert("Необходимо зарегистрироваться, чтобы продолжить!" );
        } else {
            alert("неправильный логин или пароль!1" )
        }
        
     
    } catch(e) {
        console.log('Error:', e)
    }
}
 // авторизация
const auth = async (token) => {
    try {
        const resp = await fetch(`http://localhost:8080/api/auth`, {
            method: "POST",
            headers: {
                "Authorization": "Bearer"+ " " + token
            },
        });
        const responseJson = await resp.json();
        code = responseJson.code; 
        console.log(code)
       if (code === 200) {
        location.href = 'index.html';
       } else {
        alert('неправильный логин или пароль!')
       }
     
    } catch(e) {
        console.log('Error:', e)
    }
}

