<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
namespace App\Http\Controllers;
use App\Models\Cliente; 
use Illuminate\Http\Request;
class ControllerCliente extends Controller
{
    public function index()
    {
        $clientes = Cliente::all();  // Obtém todos os clientes do banco
        return view('clientes.index', compact('clientes')); 
    }

    public function create()
    {
        return view('clientes.create');
    }

    public function store(Request $request)
    {
        $request->validate([
            'nome' => 'required',
            'endereco' => 'required',
            'telefone' => 'required',
            'email' => 'required|email|unique:clientes',
            'categoria' => 'required',
        ]);

        Cliente::create($request->all());
        return redirect()->route('clientes.index')->with('success', 'Cliente cadastrado com sucesso!');
    }

    public function edit($id)
    {
        $cliente = Cliente::findOrFail($id);
        return view('clientes.edit', compact('cliente'));
    }
    public function update(Request $request, $id) // Pegamos o ID diretamente
{
    $cliente = Cliente::findOrFail($id); // Buscamos o cliente pelo ID

    $request->validate([
        'nome' => 'required',
        'endereco' => 'required',
        'telefone' => 'required',
        'email' => 'required|email|unique:clientes,email,'.$id, // Agora passamos o $id
        'categoria' => 'required',
    ]);

    $cliente->update($request->all());
    
    return redirect()->route('clientes.index')->with('success', 'Cliente atualizado com sucesso!');
}


    public function destroy($id)
    {
        $cliente = Cliente::findOrFail($id); // Encontra o cliente ou falha
        $cliente->delete(); // Deleta o cliente
    
        return redirect()->route('clientes.index')->with('success', 'Cliente deletado com sucesso!');
    }
    
}
