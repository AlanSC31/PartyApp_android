package com.partyapp.gestiondeusuarios.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.partyapp.gestiondeusuarios.model.Grupo;
import com.partyapp.gestiondeusuarios.model.Usuario;
import com.partyapp.gestiondeusuarios.repository.GrupoRepository;
import com.partyapp.gestiondeusuarios.repository.UsuarioRepository;

@Service
public class UsuarioService {

    @Autowired
    private UsuarioRepository usuarioRep;
    @Autowired
    private GrupoRepository grupoRep;

    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    public String getAccountTypeByEmail(String email) {
        Usuario usuario = usuarioRep.findByEmail(email);
        if (usuario != null) {
            return "usuario";
        }

        Grupo grupo = grupoRep.findByEmail(email);
        if (grupo != null) {
            return "grupo";
        }

        return null;
    }

    // Usuario register
    public Usuario registerUsuario(Usuario usuario) throws Exception {
        if (usuarioRep.findByEmail(usuario.getEmail()) != null) {
            throw new Exception("El correo ya esta registrado");
        }

        // Encriptar password
        String encryptedPassword = passwordEncoder.encode(usuario.getPassword());

        usuario.setPassword(encryptedPassword);

        return usuarioRep.save(usuario);
    }

    // Usuario login
    public Usuario usuarioLogin(String email, String password) throws Exception {
        Usuario usuario = usuarioRep.findByEmail(email);
        if (usuario == null) {
            throw new Exception("Usuario no encontrado");
        }

        // password match
        if (passwordEncoder.matches(password, usuario.getPassword())) {
            return usuario;
        } else {
            throw new Exception("Contraseña incorrecta");
        }
    }

    // Usuario info
    public Usuario userInfo(String uid) throws Exception {
        Usuario usuario = usuarioRep.findByUid(uid);

        if (usuario == null) {
            throw new Exception("Usuario no encontrado");
        }
        return usuario;
    }

    // usuario update 
    public Usuario updatedUsuario(Usuario updatedUsuario) throws Exception {
        Usuario usuario = usuarioRep.findByUid(updatedUsuario.getUid());

        if (usuario == null) {
            throw new Exception("usuario no encontrado");
        }

        usuario.setName(updatedUsuario.getName());
        usuario.setLastName(updatedUsuario.getlastName());
        usuario.setEmail(updatedUsuario.getEmail());

        return usuarioRep.save(usuario);
    }

}
