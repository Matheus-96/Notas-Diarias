//
//  ListarAnotacoesTableViewController.swift
//  Notas Diarias
//
//  Created by Matheus Rodrigues Araujo on 23/10/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit
import CoreData

class ListarAnotacoesTableViewController: UITableViewController {
    
    var context: NSManagedObjectContext!
    var anotacoes: [ NSManagedObject ] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.recuperarAnotacoes()
        
    }
    
    func recuperarAnotacoes() {
        
        let requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "Anotacao")
        do {
            let anotacoesRecuperadas = try context.fetch(requisicao)
            self.anotacoes = anotacoesRecuperadas as! [ NSManagedObject ]
            self.tableView.reloadData()
        } catch let erro as Error {
            print("Erro ao recuperar anotacoes: \(erro.localizedDescription)")
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.anotacoes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath)

        let anotacao = self.anotacoes[ indexPath.row ]
        let textoRecuperado = anotacao.value(forKey: "texto")
        let dataRecuperada = anotacao.value(forKey: "data")
        
        //formatar data
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm"
        
        let novaData = dateFormatter.string(from: dataRecuperada as! Date)
        
        celula.textLabel?.text = textoRecuperado as? String
        celula.detailTextLabel?.text =  novaData
        
        return celula
    }
    
    //descobrimos qual linha foi selecionada pelo usario
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let indice = indexPath.row
        let anotacao = self.anotacoes[ indice ]
        self.performSegue(withIdentifier: "verAnotacao", sender: anotacao)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "verAnotacao" {
            let viewDestino = segue.destination as! AnotacaoViewController
            viewDestino.anotacao = sender as? NSManagedObject
            
            
        }
    }


}
