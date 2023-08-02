var constFio;
function t() {
  location.href = 'create.html';
}

  var id = 24;
  // get values from inputs for create student              
  function getValueInputs() {
    const fio = document.getElementById('fioo').value;
    const record_Number = document.getElementById('record_Number').value;
    const number = document.getElementById('groups').value;
    const birth_Date = document.getElementById('birth_Date').value;
    const city = document.getElementById('city').value;
    const number_Phone = document.getElementById('number_Phone').value;
    location.href = 'index.html';
    var scholar = 5;
    id++;
    console.log(id)
    createStudent(id, fio, record_Number, number, birth_Date, city, number_Phone, scholar);
    // console.log(parseInt(number));      
  }
    const createStudent = async (id, fio, record_Number, number, birth_Date, city, number_Phone, scholar) => {
      try {
        const response = await fetch(`http://localhost:8080/create/student?fio=${fio}&record_Number=${record_Number}&number=${number}&birth_Date=${birth_Date}&city=${city}&number_Phone=${number_Phone}&scholarship=${scholar}&id=${id}`, {
          method: 'POST'
        })
        const responseJson = await response.json();
        const data = responseJson.response;
      
      } catch (e) {
        console.log(e)
      }
}







 
// search object
function getSearchValue() {
  searchInput = document.querySelector('#search')
  const searchValue = searchInput.value;
    test(searchValue)
}
// search student
const test = async (searchValue) => {
  try {
    const response = await fetch(`http://localhost:8080/get/students/byFio?fio=${searchValue}`, {
      method: 'GET'
    })
    const responseJson = await response.json();
    let tableBody = document.getElementById("tableBody");
    const data = responseJson.response;
    console.log(data)
    tableBody.innerHTML = '';
    data.forEach(stud => {
      tableBody.innerHTML += `<tr>
      <th scope="row">${stud.id}</th>
      <td  ">${stud.fio}</td>
      <td>${stud.record_Number}</td>
      <td onclick="get(this)">${stud.number}</td>
      <td onclick="get(this)">${stud.kurs}</td>
      <td>${stud.birth_Date}</td>
      <td>${stud.city}</td>
      <td>${stud.number_Phone}</td>
      <td>${stud.category} &nbsp &nbsp 
      </td> 
      <td>
<div class="btn-group btn-group-sm" role="group">
<button  type="button" class="btn btn-outline-success" onclick="location.href = 'progress.html?fio=${stud.fio}'" >
Оформить
<i class="fa-solid fa-clock-rotate-left"></i>
</button> &nbsp &nbsp
<button type="button"  class="btn btn-outline-danger" onclick="print('${stud.id}', '${stud.fio}', '${stud.record_Number}', '${stud.number}', '${stud.birth_Date}', '${stud.city}', '${stud.number_Phone}', '${stud.kurs}')">
Изменить   
<i class="fa-solid fa-gift"></i>
</button> &nbsp &nbsp
<button  type="button" class="btn btn-outline-primary" href="/delete/student/17" onclick="confirmDelete(${stud.id})">
Удалить
<i class="fa-solid fa-clock-rotate-left"></i>
</button>
</div>
</td>
    </tr>`
    });

  }
  catch (e) {
    console.log(e)
  }
}

// delete student
const confirmDelete = async (id) => {
  if (confirm("Вы уверены, что хотите удалить этого студента?")) {
    try {
      const response = await fetch("http://localhost:8080/delete/student/" + id, {
        method: 'DELETE'
      })
      const responseJson = await response.json();
      let tableBody = document.getElementById("tableBody");
      const data = responseJson.message;
      console.log(data)
    }
    catch (e) {
      console.log(e)
    }
  }
}

const testrequest = async () => {
  try {
    const response = await fetch("http://localhost:8080/get/students/all", {
      method: 'GET'
    })
    const responseJson = await response.json();

    let tableBody = document.getElementById("tableBody");

    const data = responseJson.message;
    console.log(data)
     data.forEach(async (stud) => {
      tableBody.innerHTML += `<tr>
            <th>${stud.id}</th> 
            <td>${stud.fio}</td>
            <td>${stud.record_Number}</td>
            <td>${stud.number}</td>
            <td>${stud.kurs}</td>
            <td>${stud.birth_Date}</td>
            <td>${stud.city}</td>
            <td>${stud.number_Phone}</td>
            <td>${stud.category} &nbsp &nbsp 
            </td> 
            <td>
          
  <div class="btn-group btn-group-sm" role="group">
    <button  type="button" class="btn btn-outline-success"  onclick="location.href ='progress.html?fio=${stud.fio}'">
    Оформить
      <i class="fa-solid fa-clock-rotate-left"></i>
    </button> &nbsp &nbsp
    <button type="button" class="btn btn-outline-primary"  onclick="print('${stud.id}', '${stud.fio}', '${stud.record_Number}', '${stud.number}', '${stud.birth_Date}', '${stud.city}', '${stud.number_Phone}', '${stud.kurs}')">
      Изменить   
      <i class="fa-solid fa-gift"></i>
    </button> &nbsp &nbsp      
    <button  type="button" class="btn btn-outline-danger"   onclick="confirmDelete(${stud.id})">
    Удалить
      <i class="fa-solid fa-clock-rotate-left"></i>
    </button>&nbsp &nbsp 

    <button  type="button" class="btn btn-outline-primary" onclick = "transh('${stud.category}')" >
    Выдача
      <i class="fa-solid fa-clock-rotate-left"></i>
    </button>
  </div>
</td>
          </tr>`
     })
  } catch (e) {
    console.log(e)
  }
}
testrequest();

//------------------------------------------------------------- изменить-----------------------------------------------------------------
 function print(w, a, b, c, d, e, f, k) {
  localStorage.setItem("id", w);
  localStorage.setItem("fio", a);
  localStorage.setItem("record_Number", b);
  localStorage.setItem("groups", c);
  localStorage.setItem("birth_Date", d);
  localStorage.setItem("city", e);
  localStorage.setItem("number_Phone", f);
  localStorage.setItem("kurs", k);
   console.log(a, b, c, d, e, f,k);
  location.href = 'updatestudent.html';
}

id = localStorage.getItem("id");
document.getElementById("fio").value = localStorage.getItem("fio");
document.getElementById("record_Number").value = localStorage.getItem("record_Number");
document.getElementById("groups").value = localStorage.getItem("groups");
document.getElementById("birth_Date").value = localStorage.getItem("birth_Date");
document.getElementById("city").value = localStorage.getItem("city");
document.getElementById("number_Phone").value = localStorage.getItem("number_Phone");
document.getElementById("kurs").value = localStorage.getItem("kurs");

// Изменение данных студента 
function update() {
  fio = document.getElementById("fio").value;
  record_Number = document.getElementById("record_Number").value;
  group = document.getElementById("groups").value;
  birth_Date = document.getElementById("birth_Date").value;
  city = document.getElementById("city").value;
  number_Phone = document.getElementById("number_Phone").value;
  kurs = document.getElementById("kurs").value;

  var groupID;
  switch (group) {
    case 'ПМиИ':
      groupID = 1
      break;
    case 'МО':
      groupID = 2
      break;
    case 'ХФММ':
      groupID = 3
      break;
    case 'Лингвистика':
      groupID = 4
      break;
    case 'Геология':
      groupID = 5
      break;
    case 'ГМУ':
      groupID = 6
      break;
  }
 // console.log(id, fio, record_Number, groupID, birth_Date, city, number_Phone);
  updateStudent(id, fio, record_Number, groupID, birth_Date, city, number_Phone, kurs);
  if (confirm("Вы уверены, что хотите изменить этого студента?")) {
  location.href = 'index.html';
  }
}
const updateStudent = async (id, fio, record_Number, group, birth_Date, city, number_Phone, kurs) => {
  try {
    const response = await fetch(`http://localhost:8080/update/student?id=${id}&fio=${fio}&record_Number=${record_Number}&number=${group}&birth_Date=${birth_Date}&number_Phone=${number_Phone}&city=${city}&kurs=${kurs}`, {
      method: 'PUT'
    })
    const responseJson = await response.json();
 
  } catch (e) {
    console.log(e)
  }
}

 function transh(category) {
   if (category === 'Не оформлена') {
      alert("Для этого студента пока не оформлена стипендия")
  } else {
    location.href = 'transh.html';  
  }
}
//-------------------------------------------------------------------------------------------------------
