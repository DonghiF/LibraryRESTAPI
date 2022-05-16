<!DOCTYPE html>
<html>

<head>
  <script>
    function loadDoc() {
      const xhttp = new XMLHttpRequest();
      //gestione risposta
      xhttp.onload = function () {
        document.getElementById("demo").innerHTML = this.responseText;
        //effettuo il parsing della risposta
        let dati = JSON.parse(this.responseText);
        //inserisco i dati nell'interfaccia
        let text = "<table border='1'> <th>Autore</th><th>Titolo</th><th>ISBN</th>";
        for (let x in dati) {
          text += "<tr><td>" + dati[x].Autore + "</td>";
          text += "<td>" + dati[x].Titolo + "</td>";
          text += "<td>" + dati[x].ISBN + "</td>";
          text += "<td> <button type='button' onclick='showUpdate(" + dati[x].ISBN + ")'> Modifica </button> </td> ";
          text += "<td> <button type='button' onclick='loadDelete(" + dati[x].ISBN + ")'> Elimina </button> </td> </tr>";
        }
        text += "</table>";
        document.getElementById("demo").innerHTML = text;
      }
      //preparo l'URL
      xhttp.open("GET", "/api/book/all");
      //popolo l'intestazione
      xhttp.setRequestHeader("accept", "application/json");
      //richiamo l'URL
      xhttp.send();
    }


    function loadDelete(x) {
      var formBody = new URLSearchParams({ 'ISBN': x });


      let res = fetch("/api/book/delete", {
        method: "DELETE",
        body: formBody,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8'
        }
      });

    }

    function loadInsert(ISBN, Autore, Titolo) {
      var formBody = new URLSearchParams({ 'ISBN': ISBN, 'Titolo': Titolo, 'Autore': Autore });


      let res = fetch("/api/book/add", {
        method: "POST",
        body: formBody,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8'
        }
      });
    }

    function loadUpdate(ISBN, Autore, Titolo) {
      var formBody = new URLSearchParams({ 'ISBN': ISBN, 'Titolo': Titolo, 'Autore': Autore });


      let res = fetch("/api/book/update", {
        method: "PUT",
        body: formBody,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8'
        }
      });
    }

    function showUpdate(x) {
      document.getElementById("demo1").innerHTML = this.responseText;
      let text1 = "<form>";
        let funzione='loadUpdate('+x+', document.getElementById("autore1").value, document.getElementById("titolo1").value)';
      text1+= "<input type='text' id='isbn1' value='" + x + "' readonly></input>";
      text1 += "<input type='text' id='autore1' placeholder='Autore'>";
      text1 += "<input type='text'  id='titolo1' placeholder='Titolo'>";
      text1 += "<button type='button' onclick='"+funzione+"'>UPDATE Libri</button>";
      text1+= "</form>";
      document.getElementById("demo1").innerHTML = text1;
    }

  </script>
</head>

<body>

  <h2>BIBLIOTECA</h2>
  <p>libri disponibili: <button type="button" onclick="loadDoc()">Mostra</button></p>
  <form>
    <input type="text" name="isbn" id="isbn" placeholder="ISBN">
    <input type="text" name="autore" id="autore" placeholder="Autore">
    <input type="text" name="titolo" id="titolo" placeholder="Titolo">
    <button type="button" onclick="loadInsert(document.getElementById('isbn').value, document.getElementById('autore').value, document.getElementById('titolo').value)">Inserisci un libro</button>

  </form>
  <p id="demo"></p>
  <p id="demo1"></p>
</body>

</html>
