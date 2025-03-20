@extends('layout')

@section('content')
    <h1>Cadastrar Cliente</h1>
    <form action="{{ route('clientes.store') }}" method="POST">
        @csrf
        <label>Nome:</label>
        <input type="text" name="nome" required>
        <label>Endereço:</label>
        <input type="text" name="endereco" required>
        <label>Telefone:</label>
        <input type="text" name="telefone" required>
        <label>Email:</label>
        <input type="email" name="email" required>
        <label>Categoria:</label>
        <input type="text" name="categoria" required>
        <button type="submit">Salvar</button>
    </form>
@endsection
