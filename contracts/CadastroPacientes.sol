// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract CadastroPacientes {

    struct Paciente {
        string nome;
        uint idade;
        string cpf;
    }

    mapping(address => Paciente) public pacientes;

    function _ehNomeValido(string memory _nome) private pure returns (bool) {
        return bytes(_nome).length > 0;
    }

    function _ehIdadeValida(uint _idade) private pure returns (bool) {
        return _idade > 12;
    }

    function _ehCpfValido(string memory _cpf) private pure returns (bool) {
        return bytes(_cpf).length == 12;
    }

    function _ehPacienteValido(Paciente memory _paciente) private pure returns (bool) {
        return _ehNomeValido(_paciente.nome) &&
               _ehIdadeValida(_paciente.idade) &&
               _ehCpfValido(_paciente.cpf);
    }

    function cadastrarPaciente(string memory _nome, uint _idade, string memory _cpf) public {
        Paciente memory novoPaciente = Paciente(_nome, _idade, _cpf);

        if (_ehPacienteValido(novoPaciente)) {
            pacientes[msg.sender] = novoPaciente;
        } else {
            revert("Dados invalidos! Verifique nome, idade (>12) e CPF (12 digitos).");
        }
    }

    function consultarPaciente(address _endereco) public view returns (string memory, uint, string memory) {
        Paciente memory p = pacientes[_endereco];
        return (p.nome, p.idade, p.cpf);
    }
}