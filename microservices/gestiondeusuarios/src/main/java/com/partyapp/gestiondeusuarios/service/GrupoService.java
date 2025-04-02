package com.partyapp.gestiondeusuarios.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.partyapp.gestiondeusuarios.model.Grupo;
import com.partyapp.gestiondeusuarios.repository.GrupoRepository;

@Service
public class GrupoService {
   @Autowired
   private GrupoRepository grupoRep; 
   
   private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

   // Grupo register
   public Grupo registerGrupo(Grupo Grupo) throws Exception {
    // Validar si el correo ya esta registrado
    if(grupoRep.findByEmail(Grupo.getEmail()) != null){
        throw new Exception("El correo ya esta registrado");
    }

    // Encriptar password
    String encryptedPassword = passwordEncoder.encode(Grupo.getPassword());

    Grupo.setPassword(encryptedPassword);

    return grupoRep.save(Grupo);
   }

   // Grupo login
   public Grupo grupoLogin(String email, String password) throws Exception {
    Grupo grupo = grupoRep.findByEmail(email);
    if(grupo == null){
        throw new Exception("Grupo no encontrado");
    }

    // password match
    if(passwordEncoder.matches(password, grupo.getPassword())){
        return grupo;
    } else {
        throw new Exception("Contraseña incorrecta");
    }
   }

   // Grupo info
   public Grupo userInfo(String email) throws Exception {
    Grupo grupo = grupoRep.findByEmail(email);

    if(grupo == null){
        throw new Exception("Grupo no encontrado");
    }
    return grupo;
   }

   
}
