<!-- resources/views/clientes/index.blade.php -->

@extends('layout')

@section('title', 'Lista de Clientes')

@section('content')
    <h1>Lista de Clientes</h1>

    @if(session('success'))
        <div class="alert alert-success">
            {{ session('success') }}
        </div>
    @endif

    <!-- Botão para adicionar cliente -->
    <a href="{{ route('clientes.create') }}" class="btn btn-primary">Cadastrar Novo Cliente</a>

    <ul>
        @foreach ($clientes as $cliente)
            <li>
                {{ $cliente->nome }} - {{ $cliente->email }}

                <!-- Botão de editar -->
                <a href="{{ route('clientes.edit', $cliente->id) }}" class="btn btn-warning">Editar</a>

                <!-- Formulário para deletar o cliente -->
                <form action="{{ route('clientes.destroy', $cliente->id) }}" method="POST" style="display:inline;">
    @csrf
    @method('DELETE')
    <button type="submit" class="btn btn-danger" onclick="return confirm('Você tem certeza que deseja excluir este cliente?')">Deletar</button>
</form>

            </li>
        @endforeach
    </ul>
@endsection
