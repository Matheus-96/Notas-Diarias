//
//  AnotacaoViewController.swift
//  Notas Diarias
//
//  Created by Matheus Rodrigues Araujo on 23/10/19.
//  Copyright © 2019 Curso IOS. All rights reserved.
//

import UIKit
import CoreData

class AnotacaoViewController: UIViewController {

    @IBOutlet weak var texto: UITextView!
    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configuracoes inicais
        self.texto.becomeFirstResponder()
        self.texto.text = ""
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
    }

    
    @IBAction func salvar(_ sender: Any) {
        self.salvarAnotacao()
        
        
        //Retorna para a tela inicial
        self.navigationController?.popToRootViewController(animated: true)
        
        
    }
    
    func salvarAnotacao () {
        //Cria um objeto anotacao
        let novaAnotacao = NSEntityDescription.insertNewObject(forEntityName: "Anotacao", into: context)
        
        //configura anotacao
        novaAnotacao.setValue(self.texto.text, forKey: "texto")
        novaAnotacao.setValue( Date() , forKey: "data")
        
        do {
            try context.save()
            print("Sucesso ao salvar anotação!")
        } catch  let erro as Error {
            print("Erro ao salvar anotacao: \(erro.localizedDescription)" )
        }
    }
    

}
