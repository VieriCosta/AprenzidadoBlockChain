const express = require("express");
const path = require("path");
const app = express();

app.use(express.static(__dirname));
app.get("/contract", (req, res) => {
    const artifact = require("./build/contracts/CadastroPacientes.json");
    res.json(artifact);
});

app.listen(8080, () => console.log("Servidor rodando em http://localhost:8080"));
