@extends('layout')

@section('content')
    <h1>Editar Cliente</h1>
    <form action="{{ route('clientes.update', $cliente->id) }}" method="POST">
        @csrf
        @method('PUT')
        <label>Nome:</label>
        <input type="text" name="nome" value="{{ $cliente->nome }}" required>
        <label>Endereço:</label>
        <input type="text" name="endereco" value="{{ $cliente->endereco }}" required>
        <label>Telefone:</label>
        <input type="text" name="telefone" value="{{ $cliente->telefone }}" required>
        <label>Email:</label>
        <input type="email" name="email" value="{{ $cliente->email }}" required>
        <label>Categoria:</label>
        <input type="text" name="categoria" value="{{ $cliente->categoria }}" required>
        <button type="submit">Atualizar</button>
    </form>
@endsection
