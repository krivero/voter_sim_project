//Import express
const express = require('express');

//Create express app
const app = express();

//SEt up app to listen on port PORT
const PORT = process.env.PORT || 5000;

///

app.listen(PORT, () => {
  console.log(`Example app listening on port ${PORT}!`);
});

//Create route that responds to GET request on port 5000 and the root ('/') url
app.get('/users/:userId', (request, response) => {
  response.send(request.params.userId);
});

app.get('/about', (request, response) => {
  response.sendFile(`${__dirname}/about.html`);
});

app.post('/', (request, reponse) => {
  response.send(`This is a post request`);
});

//Add listener to port 5000 (can be any port/number)
app.listen(5000, () => {
  console.log(`Listening on port 5000`);
});
