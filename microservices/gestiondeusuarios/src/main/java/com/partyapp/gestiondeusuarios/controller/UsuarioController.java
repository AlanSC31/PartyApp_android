package com.partyapp.gestiondeusuarios.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.partyapp.gestiondeusuarios.model.Usuario;
import com.partyapp.gestiondeusuarios.service.UsuarioService;
@RestController
@RequestMapping("/users")
public class UsuarioController {
    @Autowired
    private UsuarioService usuarioServ;
    
    // Usuario register    
    @PostMapping("/usuario-register")
    public ResponseEntity<String> registerUser(@RequestBody Usuario usuario){
        try {
            usuarioServ.registerUsuario(usuario);
            return ResponseEntity.ok("Usuario registrado con exito");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Error en el registro: " + e.getMessage());
        }
    }

    // Usuario login
    @PostMapping("/usuario-login")
    public ResponseEntity<Object> login(@RequestBody Usuario usuario){
        try {
            usuarioServ.usuarioLogin(usuario.getEmail(), usuario.getPassword());

            return ResponseEntity.ok("Inicio de sesion exitoso");
        } catch (Exception e) {
            String errorMsg = e.getMessage();
            
            // Multiple errors messages
            return switch (errorMsg) {
                case "Usuario no encontrado" -> ResponseEntity.status(HttpStatus.NOT_FOUND).body("Error: Usuario no encontrado");
                case "No se encontró validación de email para el usuario" -> ResponseEntity.status(HttpStatus.NOT_FOUND).body("Error: No se encontró validación de email para el usuario");
                case "La cuenta está pendiente de confirmación" -> ResponseEntity.status(HttpStatus.FORBIDDEN).body("Error: La cuenta está pendiente de confirmación");
                case "Contraseña incorrecta" -> ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Error: Credenciales incorrectas");
                default -> ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error inesperado: " + errorMsg);
            };
        }
    }


}
