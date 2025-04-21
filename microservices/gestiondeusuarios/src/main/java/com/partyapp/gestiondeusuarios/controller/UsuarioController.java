package com.partyapp.gestiondeusuarios.controller;

import java.util.Collections;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
    public ResponseEntity<String> registerUser(@RequestBody Usuario usuario) {
        try {
            usuarioServ.registerUsuario(usuario);
            return ResponseEntity.ok("Usuario registrado con exito");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Error en el registro: " + e.getMessage());
        }
    }

    @GetMapping("/type")
    public ResponseEntity<Map<String, String>> getAccountType(@RequestParam String email) {
        String accountType = usuarioServ.getAccountTypeByEmail(email);

        if (accountType != null) {
            return ResponseEntity.ok(Collections.singletonMap("type", accountType));
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Collections.singletonMap("error", "Email no encontrado"));
        }
    }

    // show info
    @GetMapping("/info")
    public Usuario getUserInfo(@RequestParam String uid) throws Exception {
        return usuarioServ.userInfo(uid);
    }

    // update info
    @PostMapping("/usuario-update")
    public ResponseEntity<String> updateUsuario(@RequestBody Usuario usuario) {
        try {
            usuarioServ.updatedUsuario(usuario);
            return ResponseEntity.ok("Información del usuario actualizada exitosamente.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error al actualizar la información del usuario: " + e.getMessage());
        }
    }

}
