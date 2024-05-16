const express = require("express");

const app = express();

app.get("/", (req, res) => {
  res.json({
    date: new Date().toUTCString(),
  });
});

const port = 8080;
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});

