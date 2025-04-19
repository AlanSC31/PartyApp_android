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

import com.partyapp.gestiondeusuarios.model.Card;
import com.partyapp.gestiondeusuarios.service.CardService;

@RestController
@RequestMapping("/cards")
public class CardController {

    @Autowired
    private CardService cardServ;

    // card register
    @PostMapping("/card-register")
    public ResponseEntity<String> registerCard(@RequestBody Card card) {
        try {
            cardServ.registerCard(card);
            return ResponseEntity.ok("tarjeta registrada con exito");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Error en el registro: " + e.getMessage());
        }
    }

    @PostMapping("/card-update")
    public ResponseEntity<String> updateCard(@RequestBody Card card,
            @RequestParam String uid) {
        try {
            cardServ.updatedCard(card, uid);
            return ResponseEntity.ok("Información de la tarjeta actualizada exitosamente.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error al actualizar la información del grupo: " + e.getMessage());
        }
    }

    // show info
    @GetMapping("/info")
    public Card getCardInfo(@RequestParam String uid) throws Exception {
        return cardServ.cardInfo(uid);
    }

}
