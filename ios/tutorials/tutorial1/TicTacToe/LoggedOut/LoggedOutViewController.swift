//
//  LoggedOutViewController.swift
//  TicTacToe
//
//  Created by jiwon Yoon on 2023/01/19.
//  Copyright © 2023 Uber. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol LoggedOutPresentableListener: AnyObject {
    func login(withPlayer1Name player1Name: String?, player2Name: String?)
}

final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {

    weak var listener: LoggedOutPresentableListener?
    
    private var player1Field: UITextField?
    private var player2Field: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let playerFields = buildPlayerFields()
        buildLoginButton(
            withPlayer1Field: playerFields.playerField,
            player2Field: playerFields.player2Field
        )
    }
    
    private func buildPlayerFields() -> (playerField: UITextField, player2Field: UITextField) {
        let player1Field = UITextField()
        self.player1Field = player1Field
        player1Field.borderStyle = .line
        
        view.addSubview(player1Field)
        
        player1Field.placeholder = "Player 1 name"
        
        player1Field.snp.makeConstraints {
            $0.top.equalTo(self.view).offset(100.0)
            $0.leading.trailing.equalTo(self.view).inset(40.0)
            $0.height.equalTo(40.0)
        }
        
        let player2Field = UITextField()
        self.player2Field = player2Field
        player2Field.borderStyle = .line
        
        view.addSubview(player2Field)
        
        player2Field.placeholder = "Player 2 name"
        player2Field.snp.makeConstraints {
            $0.top.equalTo(player1Field.snp.bottom).offset(20.0)
            $0.leading.trailing.height.equalTo(player1Field)
        }
        
        return (player1Field, player2Field)
    }
    
    private func buildLoginButton(
        withPlayer1Field player1Field: UITextField,
        player2Field: UITextField
    ) {
        let loginButton = UIButton()
        view.addSubview(loginButton)
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(player2Field.snp.bottom).offset(20.0)
            $0.leading.trailing.height.equalTo(player1Field)
        }
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .black
        loginButton.addTarget(
            self,
            action: #selector(didTapLoginButton),
            for: .touchUpInside
        )
    }
    
    @objc
    func didTapLoginButton() {
        listener?.login(withPlayer1Name: player1Field?.text, player2Name: player2Field?.text)
    }
}
