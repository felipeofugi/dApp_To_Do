import Buffer "mo:base/Buffer";
import Bool "mo:base/Bool";
import Text "mo:base/Text";
actor {

  type Tarefa = {
    id : Nat; // Identificador único da tarefa
    categoria : Text; // Categoria da tarefa
    descricao : Text; // Descrição detalhada da tarefa
    urgente : Bool; // Indica se a tarefa é urgente (true) ou não (false)
    concluida : Bool; // Indica se a tarefa foi concluída (true) ou não (false)
  };

  var idTarefa : Nat = 0;
  var tarefas : Buffer.Buffer<Tarefa> = Buffer.Buffer<Tarefa>(10);

  public func addTarefas(cat : Text, desc : Text, urg : Bool, con : Bool) : async () {

    idTarefa += 1;
    let t : Tarefa = {
      id = idTarefa;
      categoria = cat;
      descricao = desc;
      urgente = urg;
      concluida = con;
    };

    tarefas.add(t);
  };

  public func excluirTarefa(idExcluir : Nat) : async () {
    func localizaExcluir(i : Nat, x : Tarefa) : Bool {
      return x.id != idExcluir;
    };
    tarefas.filterEntries(localizaExcluir);
  };

  public func alterartarefa(idTar : Nat, cat : Text, desc : Text, urg : Bool, con : Bool) : async () {
    let t : Tarefa = {
      id = idTar;
      categoria = cat;
      descricao = desc;
      urgente = urg;
      concluida = con;
    };

    func localizaIndex(x : Tarefa, y : Tarefa) : Bool {
      return x.id == y.id;
    };

    let index : ?Nat = Buffer.indexOf(t, tarefas, localizaIndex);

    switch (index) {
      case (null) {
        // não foi localizado um index
      };
      case (?i) {
        tarefas.put(i, t);
      };
    };
  };

  //Esta função irá retornar todas as tarefas do Buffer.
  public func getTarefas() : async [Tarefa] {
    return Buffer.toArray(tarefas);
  };

};
