import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Organiza(),
  ));
}

class Organiza extends StatefulWidget {
  const Organiza({super.key});

  @override
  State<Organiza> createState() => _OrganizaState();
}

class _OrganizaState extends State<Organiza> {
  final campo = TextEditingController();
  final tarefas = <String>[];
  final concluidas = <bool>[];

  void adicionar() {
    if (campo.text.trim().isEmpty) return;

    setState(() {
      tarefas.add(campo.text.trim());
      concluidas.add(false);
      campo.clear();
    });
  }

  @override
  void dispose() {
    campo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalConcluidas =
        concluidas.where((item) => item).length;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FC),
      appBar: AppBar(
        title: const Text(
          'Organiza+',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF3949AB),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Organize seu dia!',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$totalConcluidas de ${tarefas.length} tarefas concluídas',
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: campo,
                    decoration: InputDecoration(
                      hintText: 'Digite uma tarefa...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onSubmitted: (_) => adicionar(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: adicionar,
                  icon: const Icon(Icons.add),
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(0xFF3949AB),
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: tarefas.isEmpty
                  ? const Center(
                      child: Text(
                        'Nenhuma tarefa cadastrada.\nAdicione sua primeira atividade!',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black54),
                      ),
                    )
                  : ListView.builder(
                      itemCount: tarefas.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.white,
                          child: ListTile(
                            leading: Checkbox(
                              value: concluidas[index],
                              activeColor: const Color(0xFF3949AB),
                              onChanged: (valor) {
                                setState(() {
                                  concluidas[index] = valor ?? false;
                                });
                              },
                            ),
                            title: Text(
                              tarefas[index],
                              style: TextStyle(
                                decoration: concluidas[index]
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  tarefas.removeAt(index);
                                  concluidas.removeAt(index);
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
