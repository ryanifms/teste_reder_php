<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ControllerCliente;


// Rota para listar todos os clientes
Route::get('/', [ControllerCliente::class, 'index'])->name('clientes.index');

// Rota para exibir o formulário de cadastro de cliente
Route::get('/clientes/adicionar', [ControllerCliente::class, 'create'])->name('clientes.create');

// Rota para armazenar o cliente
Route::post('/clientes', [ControllerCliente::class, 'store'])->name('clientes.store');

// Rota para exibir o formulário de edição do cliente
Route::get('/clientes/{id}/editar', [ControllerCliente::class, 'edit'])->name('clientes.edit');

// Rota para atualizar o cliente
Route::put('/clientes/{id}', [ControllerCliente::class, 'update'])->name('clientes.update');

// Rota para deletar o cliente

Route::delete('/clientes/{id}', [ControllerCliente::class, 'destroy'])->name('clientes.destroy');
