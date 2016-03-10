//
//  ViewController.swift
//  Social Network by Juanjo Santos
//
//  Created by Juanjo Santos on 3/8/16.
//  Copyright © 2016 Juanjo Santos. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController {

    
    //Outlets
    @IBOutlet weak var emailField: StylishTextField!
    @IBOutlet weak var passwordField: StylishTextField!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    //SI YA HAY UNA SESION INICIADA, ENTONCES YA NOS SALTAMOS EL LOGIN SCREEN
    //NOS LLEVA DIRECTO AL CONTENIDO
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        //Si tenemos la sesion guardada, nos lleva directo al contenido
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil {
            self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
        }
        
    }
    
    
    //ONCE YOU LOG IN WITH FACEBOOK, WE SAVE THE SESSION, PARA QUE YA NO TENGAS QUE INICIAR SESION 
    @IBAction func fbButtonPressed(sender: UIButton!)
    {
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logInWithReadPermissions(["email"]) { (facebookResult: FBSDKLoginManagerLoginResult!,error: NSError!) -> Void in
            
            if error != nil {
                print("Error al iniciar sesion en Facebook. Error fue: \(error)")
            } else {
                //If we succeed, store access token
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                print("Logramos conectarnos con FB! Access Token fue: \(accessToken)")
                
                
                //UNA VEZ QUE YA ESTAMOS LOGGEADOS CON FB, AHORA PASARLE LOS DATOS A FIREBASE
                
                //access our static variable singleton reference to firebase
                DataService.ds.REF_BASE.authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock: { error, authData in
                    
                    //Now save a user to Firebase
                    
                    if error != nil {
                        print("Error al iniciar sesion en Firebase: \(error)")
                    } else {
                        print("Logramos conectarnos a Firebase. AuthData: \(authData)")
                        
                        //Create a Firebase user with the Facebook auth Data
                        
                        let user = ["provider": authData.provider!]
                        DataService.ds.createFirebaseUser(authData.uid, user: user)
                        
                        //Save the log in to user defaults and perform the Segue
                        NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: KEY_UID)
                        self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: self)
                        
                    }
                    
                    
                    
                })
                
                
                
            }
            
        }
        
    }
    
    
    
    
    @IBAction func loginButtonPressed(sender: UIButton!) {
        
        
        if let email = emailField.text where email != "", let pwd = passwordField.text where pwd != "" {
            
            
            //try to log in to Firebase OR REGISTER if there is no account
            
            DataService.ds.REF_BASE.authUser(email, password: pwd, withCompletionBlock: { error, authData in
                
                if error != nil {
                    print(error)
                    
                    //Si tenemos un error de que no existe el usuario (-8) entonces
                    // CREAMOS UN NUEVO USUARIO (REGISTER)
                    
                    if error.code == STATUS_ACCOUNT_NOEXIST {
                        
                        DataService.ds.REF_BASE.createUser(email, password: pwd, withValueCompletionBlock: { error, result in
                            
                            
                            //Los errores serian, que ya existe el usuario y no se puede registar
                            // o que la contrasena sea muy corta
                            
                            if error != nil {
                                self.showAlert("Registration Error", msg: "Try a different Email")
                            } else {
                                //Save the session in User Defaults
                                NSUserDefaults.standardUserDefaults().setValue(result[KEY_UID], forKey: KEY_UID)
                                
                                //Now that we have registered, Log in
                                
                                DataService.ds.REF_BASE.authUser(email, password: pwd, withCompletionBlock: { err, authData in
                                    
                                    //Create the Firebase User with the email authData
                                    let user = ["provider": authData.provider!]
                                    DataService.ds.createFirebaseUser(authData.uid, user: user)
                                    
                                })
                                
                                
                                
                                
                                
                                self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                            }
                            
                            
                        })
                        
                        
                        
                        //Si hay error de usuario o contrasena incorrecta
                    } else {
                        
                        self.showAlert("Login Error", msg: "Incorrect Email or Password")
                    }
                    
                    
                    //Si no hay error, osea QUE EL USUARIO SI EXISTE Y SE PUDO LOGGEAR
                } else {
                    self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                }
                
                
            })
            
            
            
        } else {
            //If there is no username AND password
            showAlert("Submit Error", msg: "Please fill in Email and Password")
        }
        
    }
    
    
    func showAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    


}

