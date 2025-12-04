// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract CadastroPacientes {

    struct Paciente {
        string nome;
        uint idade;
        string cpf;
        string enderecoPaciente;
        bool existe;
    }

    mapping(string => Paciente) private pacientes;
    string[] public listaCPFs;

    // ============================================================
    // CONSTRUTOR (Pacientes pré-cadastrados)
    // ============================================================

    constructor() {
        _adicionarPacienteInicial("Joao Silva", 30, "11111111111", "Rua A, 123");
        _adicionarPacienteInicial("Maria Souza", 25, "22222222222", "Avenida Central, 456");
        _adicionarPacienteInicial("Carlos Pereira", 40, "33333333333", "Rua B, 789");
    }

    function _adicionarPacienteInicial(
        string memory _nome,
        uint _idade,
        string memory _cpf,
        string memory _enderecoPaciente
    ) private {
        Paciente memory p = Paciente(_nome, _idade, _cpf, _enderecoPaciente, true);
        pacientes[_cpf] = p;
        listaCPFs.push(_cpf);
    }

    // ============================================================
    // Validações privadas
    // ============================================================

    function _ehNomeValido(string memory _nome) private pure returns (bool) {
        return bytes(_nome).length > 0;
    }

    function _ehIdadeValida(uint _idade) private pure returns (bool) {
        return _idade > 12;
    }

    function _ehCpfValido(string memory _cpf) private pure returns (bool) {
        return bytes(_cpf).length > 0;
    }

    function _cpfJaExiste(string memory _cpf) private view returns (bool) {
        return pacientes[_cpf].existe;
    }

    // ============================================================
    // Cadastro
    // ============================================================

    function cadastrarPaciente(
        string memory _nome,
        uint _idade,
        string memory _cpf,
        string memory _enderecoPaciente
    ) public {

        require(!_cpfJaExiste(_cpf), "CPF ja cadastrado.");
        require(_ehNomeValido(_nome), "Nome obrigatorio.");
        require(_ehIdadeValida(_idade), "Idade deve ser maior que 12.");
        require(_ehCpfValido(_cpf), "CPF obrigatorio.");

        Paciente memory novoPaciente = Paciente(
            _nome,
            _idade,
            _cpf,
            _enderecoPaciente,
            true
        );

        pacientes[_cpf] = novoPaciente;
        listaCPFs.push(_cpf);
    }

    // ============================================================
    // Consulta
    // ============================================================

    function consultarPaciente(string memory _cpf)
        public
        view
        returns (string memory, uint, string memory, string memory)
    {
        require(pacientes[_cpf].existe, "Paciente nao encontrado.");

        Paciente memory p = pacientes[_cpf];
        return (p.nome, p.idade, p.cpf, p.enderecoPaciente);
    }

    // ============================================================
    // Total
    // ============================================================

    function totalPacientes() public view returns (uint) {
        return listaCPFs.length;
    }
}
