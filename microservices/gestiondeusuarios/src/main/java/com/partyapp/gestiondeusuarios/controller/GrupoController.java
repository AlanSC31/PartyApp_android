package com.partyapp.gestiondeusuarios.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.partyapp.gestiondeusuarios.model.Grupo;
import com.partyapp.gestiondeusuarios.service.GrupoService;
@RestController
@RequestMapping("/groups")
public class GrupoController {
    @Autowired
    private GrupoService grupoServ;
    
    // Grupo register    
    @PostMapping("/grupo-register")
    public ResponseEntity<String> registerGroup(@RequestBody Grupo grupo){
        try {
            grupoServ.registerGrupo(grupo);
            return ResponseEntity.ok("Grupo registrado con exito");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Error en el registro: " + e.getMessage());
        }
    }

    // Grupo login
    @PostMapping("/grupo-login")
    public ResponseEntity<Object> login(@RequestBody Grupo grupo){
        try {
            grupoServ.grupoLogin(grupo.getEmail(), grupo.getPassword());

            return ResponseEntity.ok("Inicio de sesion exitoso");
        } catch (Exception e) {
            String errorMsg = e.getMessage();
            
            // Multiple errors messages
            return switch (errorMsg) {
                case "Grupo no encontrado" -> ResponseEntity.status(HttpStatus.NOT_FOUND).body("Error: Grupo no encontrado");
                case "No se encontró validación de email para el grupo" -> ResponseEntity.status(HttpStatus.NOT_FOUND).body("Error: No se encontró validación de email para el grupo");
                case "La cuenta está pendiente de confirmación" -> ResponseEntity.status(HttpStatus.FORBIDDEN).body("Error: La cuenta está pendiente de confirmación");
                case "Contraseña incorrecta" -> ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Error: Credenciales incorrectas");
                default -> ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error inesperado: " + errorMsg);
            };
        }
    }

    // show info
    @GetMapping("/info")
    public Grupo getUserInfo(@RequestParam String uid) throws Exception {
        return grupoServ.userInfo(uid);
    }

    // update info
    @PostMapping("/grupo-update")
    public ResponseEntity<String> updateGrupo(@RequestBody Grupo grupo) {
        try {
            grupoServ.updatedGrupo(grupo);
            return ResponseEntity.ok("Información del grupo actualizada exitosamente.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error al actualizar la información del grupo: " + e.getMessage());
        }
    }
}